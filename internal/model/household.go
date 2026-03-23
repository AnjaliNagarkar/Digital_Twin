package model

import "time"

// Household represents a single household — the core geo-entity of the digital twin.
type Household struct {
	ID             int64     `json:"id"`
	HeadName       string    `json:"head_name"`
	Address        string    `json:"address"`
	WardNo         int       `json:"ward_no"`
	Lat            float64   `json:"lat"`
	Lng            float64   `json:"lng"`
	TotalMembers   int       `json:"total_members"`
	AnnualIncome   float64   `json:"annual_income"`
	BPL            bool      `json:"bpl"`
	RationCard     string    `json:"ration_card"`
	HouseType      string    `json:"house_type"`
	HasToilet      bool      `json:"has_toilet"`
	HasElectricity bool      `json:"has_electricity"`
	HasWaterSupply bool      `json:"has_water_supply"`
	HasGas         bool      `json:"has_gas"`
	CreatedAt      time.Time `json:"created_at"`
	UpdatedAt      time.Time `json:"updated_at"`

	// Populated on detail endpoint only
	Members     []FamilyMember `json:"members,omitempty"`
	Agriculture []AgriRecord   `json:"agriculture,omitempty"`
	Schemes     []SchemeEnroll `json:"schemes,omitempty"`
	Assets      []Asset        `json:"assets,omitempty"`
}

// FamilyMember is a sub-entity linked to a household.
type FamilyMember struct {
	ID          int64   `json:"id"`
	HouseholdID int64   `json:"household_id"`
	Name        string  `json:"name"`
	Relation    string  `json:"relation"`
	Gender      string  `json:"gender"`
	DateOfBirth string  `json:"date_of_birth"`
	Age         int     `json:"age"`
	Education   string  `json:"education"`
	Occupation  *string `json:"occupation"`
	IsDisabled  bool    `json:"is_disabled"`
}

// AgriRecord represents a single agriculture entry for a household.
type AgriRecord struct {
	ID             int64    `json:"id"`
	HouseholdID    int64    `json:"household_id"`
	LandAreaAcres  float64  `json:"land_area_acres"`
	CropType       string   `json:"crop_type"`
	Season         string   `json:"season"`
	IrrigationType string   `json:"irrigation_type"`
	SoilType       *string  `json:"soil_type"`
	AnnualYieldKg  *float64 `json:"annual_yield_kg"`
	CropYear       int      `json:"crop_year"`
}

// Asset represents a household asset for economic profiling.
type Asset struct {
	ID          int64    `json:"id"`
	HouseholdID int64    `json:"household_id"`
	AssetType   string   `json:"asset_type"`
	Description string   `json:"description"`
	Quantity    int      `json:"quantity"`
	EstValue    *float64 `json:"est_value"`
}

// HouseListFilter holds all possible filter parameters for the list endpoint.
type HouseListFilter struct {
	BPL            *bool
	HasToilet      *bool
	HasElectricity *bool
	HasWaterSupply *bool
	SchemeCode     string
	CropType       string
	WardNo         *int
	MinLat         *float64
	MaxLat         *float64
	MinLng         *float64
	MaxLng         *float64
	Page           int
	PageSize       int
}

// Stats holds summary statistics for the dashboard.
type Stats struct {
	TotalHouseholds  int     `json:"total_households"`
	TotalPopulation  int     `json:"total_population"`
	AvgIncome        float64 `json:"avg_income"`
	BPLCount         int     `json:"bpl_count"`
	APLCount         int     `json:"apl_count"`
	ToiletCoverage   float64 `json:"toilet_coverage_pct"`
	ElectricityCov   float64 `json:"electricity_coverage_pct"`
	WaterCoverage    float64 `json:"water_coverage_pct"`
	TotalFarmers     int     `json:"total_farmers"`
	TotalLandAcres   float64 `json:"total_land_acres"`
}
