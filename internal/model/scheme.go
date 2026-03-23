package model

// Scheme represents a government welfare scheme (master record).
type Scheme struct {
	ID          int64  `json:"id"`
	Name        string `json:"name"`
	Code        string `json:"code"`
	Category    string `json:"category"`
	Description string `json:"description"`
}

// SchemeEnroll represents a household's enrollment in a scheme (joined view).
type SchemeEnroll struct {
	ID           int64  `json:"id"`
	HouseholdID  int64  `json:"household_id"`
	SchemeID     int64  `json:"scheme_id"`
	SchemeName   string `json:"scheme_name"`
	SchemeCode   string `json:"scheme_code"`
	Category     string `json:"category"`
	EnrolledOn   string `json:"enrolled_on"`
	Status       string `json:"status"`
}
