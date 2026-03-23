package model

// ─── Governance Insights ────────────────────────────────────

type GovernanceInsight struct {
	TotalHouseholds    int       `json:"total_households"`
	WithoutToilet      int       `json:"without_toilet"`
	WithoutElectricity int       `json:"without_electricity"`
	WithoutWater       int       `json:"without_water"`
	WithoutGas         int       `json:"without_gas"`
	ToiletPct          float64   `json:"toilet_coverage_pct"`
	ElectricityPct     float64   `json:"electricity_coverage_pct"`
	WaterPct           float64   `json:"water_coverage_pct"`
	GasPct             float64   `json:"gas_coverage_pct"`
	GapsByWard         []WardGap `json:"gaps_by_ward"`
}

type WardGap struct {
	WardNo             int `json:"ward_no"`
	Total              int `json:"total"`
	WithoutToilet      int `json:"without_toilet"`
	WithoutElectricity int `json:"without_electricity"`
	WithoutWater       int `json:"without_water"`
}

// ─── Agriculture Insights ───────────────────────────────────

type AgriInsight struct {
	TotalFarmingHouseholds int         `json:"total_farming_households"`
	TotalLandAcres         float64     `json:"total_land_acres"`
	IrrigationBreakdown    []NameCount `json:"irrigation_breakdown"`
	CropDistribution       []NameCount `json:"crop_distribution"`
	SeasonBreakdown        []NameCount `json:"season_breakdown"`
	RainfedPct             float64     `json:"rainfed_pct"`
	AvgYieldPerAcre        float64     `json:"avg_yield_per_acre"`
	RiskHouseholds         int         `json:"risk_households"`
}

// ─── Welfare Insights ───────────────────────────────────────

type WelfareInsight struct {
	TotalSchemes       int              `json:"total_schemes"`
	TotalEnrollments   int              `json:"total_enrollments"`
	BPLWithoutScheme   int              `json:"bpl_without_any_scheme"`
	SchemeCoverage     []SchemeCoverage `json:"scheme_coverage"`
	EligibilityGaps    []EligibilityGap `json:"eligibility_gaps"`
}

type SchemeCoverage struct {
	Name     string `json:"name"`
	Code     string `json:"code"`
	Category string `json:"category"`
	Enrolled int    `json:"enrolled"`
}

type EligibilityGap struct {
	HouseholdID int64  `json:"household_id"`
	HeadName    string `json:"head_name"`
	Reason      string `json:"reason"`
}

// ─── Geo Insights ───────────────────────────────────────────

type GeoInsight struct {
	BoundingBox [4]float64 `json:"bounding_box"` // [minLat, minLng, maxLat, maxLng]
	GridCells   []GridCell `json:"grid_cells"`
	DenseAreas  []GridCell `json:"dense_areas"`
	TotalArea   float64    `json:"approx_area_sq_km"`
}

type GridCell struct {
	GridLat   float64 `json:"grid_lat"`
	GridLng   float64 `json:"grid_lng"`
	Count     int     `json:"count"`
	AvgIncome float64 `json:"avg_income"`
}

// ─── Shared ─────────────────────────────────────────────────

type NameCount struct {
	Name  string `json:"name"`
	Count int    `json:"count"`
}
