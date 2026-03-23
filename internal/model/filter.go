package model

// SchemeRef is a lightweight scheme reference for filter dropdowns.
type SchemeRef struct {
	Code string `json:"code"`
	Name string `json:"name"`
}

// FilterOptions holds all available filter values for the frontend dropdowns.
type FilterOptions struct {
	CropTypes       []string    `json:"crop_types"`
	Schemes         []SchemeRef `json:"schemes"`
	Wards           []int       `json:"wards"`
	HouseTypes      []string    `json:"house_types"`
	IrrigationTypes []string    `json:"irrigation_types"`
	RationCards     []string    `json:"ration_cards"`
	BoolFilters     []string    `json:"bool_filters"`
}
