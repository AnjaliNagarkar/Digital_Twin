package repository

import (
	"context"
	"database/sql"
	"fmt"
	"math"

	"village-twin/internal/model"
)

// InsightRepository defines data access for insight/analytics queries.
type InsightRepository interface {
	GovernanceGaps(ctx context.Context) (*model.GovernanceInsight, error)
	AgricultureAnalysis(ctx context.Context) (*model.AgriInsight, error)
	WelfareCoverage(ctx context.Context) (*model.WelfareInsight, error)
	GeoClustering(ctx context.Context, gridSize float64) (*model.GeoInsight, error)
}

type mysqlInsightRepo struct {
	db *sql.DB
}

// NewInsightRepo creates a MySQL-backed InsightRepository.
func NewInsightRepo(db *sql.DB) InsightRepository {
	return &mysqlInsightRepo{db: db}
}

// ─── Governance ─────────────────────────────────────────────

func (r *mysqlInsightRepo) GovernanceGaps(ctx context.Context) (*model.GovernanceInsight, error) {
	// Overall gaps
	overallQ := `SELECT
		COUNT(*),
		SUM(has_toilet = 0),
		SUM(has_electricity = 0),
		SUM(has_water_supply = 0),
		SUM(has_gas = 0)
	FROM households`

	var g model.GovernanceInsight
	err := r.db.QueryRowContext(ctx, overallQ).Scan(
		&g.TotalHouseholds,
		&g.WithoutToilet,
		&g.WithoutElectricity,
		&g.WithoutWater,
		&g.WithoutGas,
	)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.GovernanceGaps overall: %w", err)
	}

	if g.TotalHouseholds > 0 {
		t := float64(g.TotalHouseholds)
		g.ToiletPct = math.Round((float64(g.TotalHouseholds-g.WithoutToilet)/t)*1000) / 10
		g.ElectricityPct = math.Round((float64(g.TotalHouseholds-g.WithoutElectricity)/t)*1000) / 10
		g.WaterPct = math.Round((float64(g.TotalHouseholds-g.WithoutWater)/t)*1000) / 10
		g.GasPct = math.Round((float64(g.TotalHouseholds-g.WithoutGas)/t)*1000) / 10
	}

	// Gaps by ward
	wardQ := `SELECT
		ward_no,
		COUNT(*),
		SUM(has_toilet = 0),
		SUM(has_electricity = 0),
		SUM(has_water_supply = 0)
	FROM households
	GROUP BY ward_no
	ORDER BY ward_no`

	rows, err := r.db.QueryContext(ctx, wardQ)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.GovernanceGaps wards: %w", err)
	}
	defer rows.Close()

	for rows.Next() {
		var w model.WardGap
		if err := rows.Scan(&w.WardNo, &w.Total, &w.WithoutToilet, &w.WithoutElectricity, &w.WithoutWater); err != nil {
			return nil, fmt.Errorf("insight_repo.GovernanceGaps ward scan: %w", err)
		}
		g.GapsByWard = append(g.GapsByWard, w)
	}

	return &g, rows.Err()
}

// ─── Agriculture ────────────────────────────────────────────

func (r *mysqlInsightRepo) AgricultureAnalysis(ctx context.Context) (*model.AgriInsight, error) {
	var a model.AgriInsight

	// Totals
	totQ := `SELECT
		COUNT(DISTINCT household_id),
		COALESCE(SUM(land_area_acres), 0)
	FROM agriculture`
	if err := r.db.QueryRowContext(ctx, totQ).Scan(&a.TotalFarmingHouseholds, &a.TotalLandAcres); err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis totals: %w", err)
	}

	// Rainfed % and avg yield
	pctQ := `SELECT
		COALESCE(ROUND(SUM(irrigation_type = 'Rainfed') * 100.0 / NULLIF(COUNT(*), 0), 1), 0),
		COALESCE(ROUND(SUM(annual_yield_kg) / NULLIF(SUM(land_area_acres), 0), 1), 0)
	FROM agriculture`
	if err := r.db.QueryRowContext(ctx, pctQ).Scan(&a.RainfedPct, &a.AvgYieldPerAcre); err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis pct: %w", err)
	}

	// Risk households: rainfed AND BPL
	riskQ := `SELECT COUNT(DISTINCT a.household_id)
		FROM agriculture a
		JOIN households h ON a.household_id = h.id
		WHERE a.irrigation_type = 'Rainfed' AND h.bpl = 1`
	if err := r.db.QueryRowContext(ctx, riskQ).Scan(&a.RiskHouseholds); err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis risk: %w", err)
	}

	// Irrigation breakdown
	var err error
	a.IrrigationBreakdown, err = r.nameCountQuery(ctx,
		"SELECT irrigation_type, COUNT(*) FROM agriculture GROUP BY irrigation_type ORDER BY COUNT(*) DESC")
	if err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis irrigation: %w", err)
	}

	// Crop distribution
	a.CropDistribution, err = r.nameCountQuery(ctx,
		"SELECT crop_type, COUNT(*) FROM agriculture GROUP BY crop_type ORDER BY COUNT(*) DESC")
	if err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis crop: %w", err)
	}

	// Season breakdown
	a.SeasonBreakdown, err = r.nameCountQuery(ctx,
		"SELECT season, COUNT(*) FROM agriculture GROUP BY season ORDER BY COUNT(*) DESC")
	if err != nil {
		return nil, fmt.Errorf("insight_repo.AgricultureAnalysis season: %w", err)
	}

	return &a, nil
}

// ─── Welfare ────────────────────────────────────────────────

func (r *mysqlInsightRepo) WelfareCoverage(ctx context.Context) (*model.WelfareInsight, error) {
	var w model.WelfareInsight

	// Total schemes
	if err := r.db.QueryRowContext(ctx, "SELECT COUNT(*) FROM schemes").Scan(&w.TotalSchemes); err != nil {
		return nil, fmt.Errorf("insight_repo.WelfareCoverage total: %w", err)
	}

	// Total active enrollments
	if err := r.db.QueryRowContext(ctx,
		"SELECT COUNT(*) FROM household_schemes WHERE status = 'Active'").Scan(&w.TotalEnrollments); err != nil {
		return nil, fmt.Errorf("insight_repo.WelfareCoverage enrollments: %w", err)
	}

	// BPL households without any active scheme
	bplQ := `SELECT COUNT(*) FROM households h
		LEFT JOIN household_schemes hs ON h.id = hs.household_id AND hs.status = 'Active'
		WHERE h.bpl = 1 AND hs.id IS NULL`
	if err := r.db.QueryRowContext(ctx, bplQ).Scan(&w.BPLWithoutScheme); err != nil {
		return nil, fmt.Errorf("insight_repo.WelfareCoverage bpl_gap: %w", err)
	}

	// Per-scheme coverage
	scQ := `SELECT s.name, s.code, s.category, COUNT(hs.id)
		FROM schemes s
		LEFT JOIN household_schemes hs ON s.id = hs.scheme_id AND hs.status = 'Active'
		GROUP BY s.id, s.name, s.code, s.category
		ORDER BY s.name`
	scRows, err := r.db.QueryContext(ctx, scQ)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.WelfareCoverage scheme_cov: %w", err)
	}
	defer scRows.Close()

	for scRows.Next() {
		var sc model.SchemeCoverage
		if err := scRows.Scan(&sc.Name, &sc.Code, &sc.Category, &sc.Enrolled); err != nil {
			return nil, fmt.Errorf("insight_repo.WelfareCoverage scheme_cov scan: %w", err)
		}
		w.SchemeCoverage = append(w.SchemeCoverage, sc)
	}
	if err := scRows.Err(); err != nil {
		return nil, err
	}

	// Eligibility gaps: BPL + Kuccha NOT in PMAY
	gapQ := `SELECT h.id, h.head_name
		FROM households h
		WHERE h.bpl = 1 AND h.house_type = 'Kuccha'
		  AND h.id NOT IN (
		    SELECT hs.household_id FROM household_schemes hs
		    JOIN schemes s ON hs.scheme_id = s.id
		    WHERE s.code = 'PMAY' AND hs.status = 'Active'
		  )
		ORDER BY h.id`
	gapRows, err := r.db.QueryContext(ctx, gapQ)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.WelfareCoverage gaps: %w", err)
	}
	defer gapRows.Close()

	for gapRows.Next() {
		var eg model.EligibilityGap
		if err := gapRows.Scan(&eg.HouseholdID, &eg.HeadName); err != nil {
			return nil, fmt.Errorf("insight_repo.WelfareCoverage gap scan: %w", err)
		}
		eg.Reason = "BPL + Kuccha house — eligible for PMAY but not enrolled"
		w.EligibilityGaps = append(w.EligibilityGaps, eg)
	}

	return &w, gapRows.Err()
}

// ─── Geo Clustering ─────────────────────────────────────────

func (r *mysqlInsightRepo) GeoClustering(ctx context.Context, gridSize float64) (*model.GeoInsight, error) {
	if gridSize <= 0 {
		gridSize = 0.001 // ~111m grid cells
	}

	var g model.GeoInsight

	// Bounding box
	bbQ := `SELECT MIN(lat), MIN(lng), MAX(lat), MAX(lng) FROM households`
	err := r.db.QueryRowContext(ctx, bbQ).Scan(
		&g.BoundingBox[0], &g.BoundingBox[1], &g.BoundingBox[2], &g.BoundingBox[3],
	)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.GeoClustering bbox: %w", err)
	}

	// Approximate area (Haversine-simplified)
	latDiff := (g.BoundingBox[2] - g.BoundingBox[0]) * 111.0
	midLat := (g.BoundingBox[0] + g.BoundingBox[2]) / 2.0
	lngDiff := (g.BoundingBox[3] - g.BoundingBox[1]) * 111.0 * math.Cos(midLat*math.Pi/180.0)
	g.TotalArea = math.Round(latDiff*lngDiff*100) / 100

	// Grid-based clustering
	gridQ := fmt.Sprintf(`SELECT
		ROUND(lat / %f) * %f AS grid_lat,
		ROUND(lng / %f) * %f AS grid_lng,
		COUNT(*) AS cnt,
		ROUND(AVG(annual_income), 2) AS avg_inc
	FROM households
	GROUP BY grid_lat, grid_lng
	ORDER BY cnt DESC`, gridSize, gridSize, gridSize, gridSize)

	rows, err := r.db.QueryContext(ctx, gridQ)
	if err != nil {
		return nil, fmt.Errorf("insight_repo.GeoClustering grid: %w", err)
	}
	defer rows.Close()

	var totalCount int
	for rows.Next() {
		var gc model.GridCell
		if err := rows.Scan(&gc.GridLat, &gc.GridLng, &gc.Count, &gc.AvgIncome); err != nil {
			return nil, fmt.Errorf("insight_repo.GeoClustering grid scan: %w", err)
		}
		g.GridCells = append(g.GridCells, gc)
		totalCount += gc.Count
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	// Dense areas: cells above 1.5× mean count
	if len(g.GridCells) > 0 {
		meanCount := float64(totalCount) / float64(len(g.GridCells))
		threshold := meanCount * 1.5
		for _, gc := range g.GridCells {
			if float64(gc.Count) >= threshold {
				g.DenseAreas = append(g.DenseAreas, gc)
			}
		}
	}

	return &g, nil
}

// ─── Helpers ────────────────────────────────────────────────

func (r *mysqlInsightRepo) nameCountQuery(ctx context.Context, q string) ([]model.NameCount, error) {
	rows, err := r.db.QueryContext(ctx, q)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var result []model.NameCount
	for rows.Next() {
		var nc model.NameCount
		if err := rows.Scan(&nc.Name, &nc.Count); err != nil {
			return nil, err
		}
		result = append(result, nc)
	}
	return result, rows.Err()
}
