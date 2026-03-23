package repository

import (
	"context"
	"database/sql"
	"fmt"
	"strings"

	"village-twin/internal/model"
)

// HouseholdRepository defines data access operations for households.
type HouseholdRepository interface {
	List(ctx context.Context, f model.HouseListFilter) ([]model.Household, int, error)
	GetByID(ctx context.Context, id int64) (*model.Household, error)
	GetMembers(ctx context.Context, householdID int64) ([]model.FamilyMember, error)
	GetAgriculture(ctx context.Context, householdID int64) ([]model.AgriRecord, error)
	GetSchemes(ctx context.Context, householdID int64) ([]model.SchemeEnroll, error)
	GetAssets(ctx context.Context, householdID int64) ([]model.Asset, error)
	GetStats(ctx context.Context) (*model.Stats, error)
}

type mysqlHouseholdRepo struct {
	db *sql.DB
}

// NewHouseholdRepo creates a MySQL-backed HouseholdRepository.
func NewHouseholdRepo(db *sql.DB) HouseholdRepository {
	return &mysqlHouseholdRepo{db: db}
}

// List returns filtered, paginated households. Dynamic WHERE builder avoids N² query variants.
func (r *mysqlHouseholdRepo) List(ctx context.Context, f model.HouseListFilter) ([]model.Household, int, error) {
	var (
		where []string
		args  []interface{}
		joins []string
	)

	if f.BPL != nil {
		where = append(where, "h.bpl = ?")
		args = append(args, boolToInt(*f.BPL))
	}
	if f.HasToilet != nil {
		where = append(where, "h.has_toilet = ?")
		args = append(args, boolToInt(*f.HasToilet))
	}
	if f.HasElectricity != nil {
		where = append(where, "h.has_electricity = ?")
		args = append(args, boolToInt(*f.HasElectricity))
	}
	if f.HasWaterSupply != nil {
		where = append(where, "h.has_water_supply = ?")
		args = append(args, boolToInt(*f.HasWaterSupply))
	}
	if f.WardNo != nil {
		where = append(where, "h.ward_no = ?")
		args = append(args, *f.WardNo)
	}
	if f.SchemeCode != "" {
		joins = append(joins, "JOIN household_schemes hs ON h.id = hs.household_id JOIN schemes s ON hs.scheme_id = s.id")
		where = append(where, "s.code = ?")
		args = append(args, f.SchemeCode)
	}
	if f.CropType != "" {
		joins = append(joins, "JOIN agriculture a ON h.id = a.household_id")
		where = append(where, "a.crop_type = ?")
		args = append(args, f.CropType)
	}
	if f.MinLat != nil && f.MaxLat != nil {
		where = append(where, "h.lat BETWEEN ? AND ?")
		args = append(args, *f.MinLat, *f.MaxLat)
	}
	if f.MinLng != nil && f.MaxLng != nil {
		where = append(where, "h.lng BETWEEN ? AND ?")
		args = append(args, *f.MinLng, *f.MaxLng)
	}

	// Build query
	var qb strings.Builder
	qb.WriteString("SELECT h.id, h.head_name, h.address, h.ward_no, h.lat, h.lng, h.total_members, h.annual_income, h.bpl, h.ration_card, h.house_type, h.has_toilet, h.has_electricity, h.has_water_supply, h.has_gas, h.created_at, h.updated_at FROM households h ")
	for _, j := range joins {
		qb.WriteString(j)
		qb.WriteString(" ")
	}
	if len(where) > 0 {
		qb.WriteString("WHERE ")
		qb.WriteString(strings.Join(where, " AND "))
		qb.WriteString(" ")
	}
	if len(joins) > 0 {
		qb.WriteString("GROUP BY h.id ")
	}
	qb.WriteString("ORDER BY h.id ")

	// Count query (same WHERE but SELECT COUNT)
	var cqb strings.Builder
	cqb.WriteString("SELECT COUNT(DISTINCT h.id) FROM households h ")
	for _, j := range joins {
		cqb.WriteString(j)
		cqb.WriteString(" ")
	}
	if len(where) > 0 {
		cqb.WriteString("WHERE ")
		cqb.WriteString(strings.Join(where, " AND "))
	}

	var total int
	if err := r.db.QueryRowContext(ctx, cqb.String(), args...).Scan(&total); err != nil {
		return nil, 0, fmt.Errorf("household_repo.List count: %w", err)
	}

	// Pagination
	offset := (f.Page - 1) * f.PageSize
	qb.WriteString(fmt.Sprintf("LIMIT %d OFFSET %d", f.PageSize, offset))

	rows, err := r.db.QueryContext(ctx, qb.String(), args...)
	if err != nil {
		return nil, 0, fmt.Errorf("household_repo.List query: %w", err)
	}
	defer rows.Close()

	var houses []model.Household
	for rows.Next() {
		var h model.Household
		if err := rows.Scan(
			&h.ID, &h.HeadName, &h.Address, &h.WardNo,
			&h.Lat, &h.Lng, &h.TotalMembers, &h.AnnualIncome,
			&h.BPL, &h.RationCard, &h.HouseType,
			&h.HasToilet, &h.HasElectricity, &h.HasWaterSupply, &h.HasGas,
			&h.CreatedAt, &h.UpdatedAt,
		); err != nil {
			return nil, 0, fmt.Errorf("household_repo.List scan: %w", err)
		}
		houses = append(houses, h)
	}
	return houses, total, rows.Err()
}

// GetByID returns a single household (without nested relations).
func (r *mysqlHouseholdRepo) GetByID(ctx context.Context, id int64) (*model.Household, error) {
	q := `SELECT id, head_name, address, ward_no, lat, lng, total_members, annual_income,
	       bpl, ration_card, house_type, has_toilet, has_electricity, has_water_supply, has_gas,
	       created_at, updated_at
	      FROM households WHERE id = ?`

	var h model.Household
	err := r.db.QueryRowContext(ctx, q, id).Scan(
		&h.ID, &h.HeadName, &h.Address, &h.WardNo,
		&h.Lat, &h.Lng, &h.TotalMembers, &h.AnnualIncome,
		&h.BPL, &h.RationCard, &h.HouseType,
		&h.HasToilet, &h.HasElectricity, &h.HasWaterSupply, &h.HasGas,
		&h.CreatedAt, &h.UpdatedAt,
	)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetByID: %w", err)
	}
	return &h, nil
}

// GetMembers returns all family members for a household.
func (r *mysqlHouseholdRepo) GetMembers(ctx context.Context, householdID int64) ([]model.FamilyMember, error) {
	q := `SELECT id, household_id, name, relation, gender, date_of_birth,
	       TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,
	       education, occupation, is_disabled
	      FROM family_members WHERE household_id = ? ORDER BY
	       FIELD(relation, 'Head','Spouse','Father','Mother','Son','Daughter','Other'), date_of_birth`

	rows, err := r.db.QueryContext(ctx, q, householdID)
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetMembers: %w", err)
	}
	defer rows.Close()

	var members []model.FamilyMember
	for rows.Next() {
		var m model.FamilyMember
		if err := rows.Scan(
			&m.ID, &m.HouseholdID, &m.Name, &m.Relation, &m.Gender,
			&m.DateOfBirth, &m.Age, &m.Education, &m.Occupation, &m.IsDisabled,
		); err != nil {
			return nil, fmt.Errorf("household_repo.GetMembers scan: %w", err)
		}
		members = append(members, m)
	}
	return members, rows.Err()
}

// GetAgriculture returns all agriculture records for a household.
func (r *mysqlHouseholdRepo) GetAgriculture(ctx context.Context, householdID int64) ([]model.AgriRecord, error) {
	q := `SELECT id, household_id, land_area_acres, crop_type, season, irrigation_type,
	       soil_type, annual_yield_kg, crop_year
	      FROM agriculture WHERE household_id = ? ORDER BY crop_year DESC`

	rows, err := r.db.QueryContext(ctx, q, householdID)
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetAgriculture: %w", err)
	}
	defer rows.Close()

	var records []model.AgriRecord
	for rows.Next() {
		var a model.AgriRecord
		if err := rows.Scan(
			&a.ID, &a.HouseholdID, &a.LandAreaAcres, &a.CropType,
			&a.Season, &a.IrrigationType, &a.SoilType, &a.AnnualYieldKg, &a.CropYear,
		); err != nil {
			return nil, fmt.Errorf("household_repo.GetAgriculture scan: %w", err)
		}
		records = append(records, a)
	}
	return records, rows.Err()
}

// GetSchemes returns all scheme enrollments for a household (joined with scheme details).
func (r *mysqlHouseholdRepo) GetSchemes(ctx context.Context, householdID int64) ([]model.SchemeEnroll, error) {
	q := `SELECT hs.id, hs.household_id, hs.scheme_id, s.name, s.code, s.category,
	       hs.enrolled_on, hs.status
	      FROM household_schemes hs
	      JOIN schemes s ON hs.scheme_id = s.id
	      WHERE hs.household_id = ? ORDER BY hs.enrolled_on DESC`

	rows, err := r.db.QueryContext(ctx, q, householdID)
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetSchemes: %w", err)
	}
	defer rows.Close()

	var enrollments []model.SchemeEnroll
	for rows.Next() {
		var se model.SchemeEnroll
		if err := rows.Scan(
			&se.ID, &se.HouseholdID, &se.SchemeID, &se.SchemeName, &se.SchemeCode,
			&se.Category, &se.EnrolledOn, &se.Status,
		); err != nil {
			return nil, fmt.Errorf("household_repo.GetSchemes scan: %w", err)
		}
		enrollments = append(enrollments, se)
	}
	return enrollments, rows.Err()
}

// GetAssets returns all assets for a household.
func (r *mysqlHouseholdRepo) GetAssets(ctx context.Context, householdID int64) ([]model.Asset, error) {
	q := `SELECT id, household_id, asset_type, description, quantity, est_value
	      FROM assets WHERE household_id = ? ORDER BY asset_type`

	rows, err := r.db.QueryContext(ctx, q, householdID)
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetAssets: %w", err)
	}
	defer rows.Close()

	var assets []model.Asset
	for rows.Next() {
		var a model.Asset
		if err := rows.Scan(
			&a.ID, &a.HouseholdID, &a.AssetType, &a.Description,
			&a.Quantity, &a.EstValue,
		); err != nil {
			return nil, fmt.Errorf("household_repo.GetAssets scan: %w", err)
		}
		assets = append(assets, a)
	}
	return assets, rows.Err()
}

// GetStats returns summary statistics for the dashboard.
func (r *mysqlHouseholdRepo) GetStats(ctx context.Context) (*model.Stats, error) {
	q := `SELECT
		COUNT(*),
		COALESCE(SUM(total_members), 0),
		COALESCE(ROUND(AVG(annual_income), 2), 0),
		SUM(bpl = 1),
		SUM(bpl = 0),
		ROUND(SUM(has_toilet = 1) * 100.0 / COUNT(*), 1),
		ROUND(SUM(has_electricity = 1) * 100.0 / COUNT(*), 1),
		ROUND(SUM(has_water_supply = 1) * 100.0 / COUNT(*), 1)
	FROM households`

	var s model.Stats
	err := r.db.QueryRowContext(ctx, q).Scan(
		&s.TotalHouseholds, &s.TotalPopulation, &s.AvgIncome,
		&s.BPLCount, &s.APLCount,
		&s.ToiletCoverage, &s.ElectricityCov, &s.WaterCoverage,
	)
	if err != nil {
		return nil, fmt.Errorf("household_repo.GetStats: %w", err)
	}

	// Agriculture summary
	aq := `SELECT COUNT(DISTINCT household_id), COALESCE(SUM(land_area_acres), 0) FROM agriculture`
	if err := r.db.QueryRowContext(ctx, aq).Scan(&s.TotalFarmers, &s.TotalLandAcres); err != nil {
		return nil, fmt.Errorf("household_repo.GetStats agri: %w", err)
	}

	return &s, nil
}

func boolToInt(b bool) int {
	if b {
		return 1
	}
	return 0
}
