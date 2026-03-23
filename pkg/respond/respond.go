package respond

import (
	"encoding/json"
	"net/http"

	"village-twin/internal/model"
)

// OK sends a successful JSON response with data.
func OK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(model.APIResponse{
		Success: true,
		Data:    data,
	})
}

// Paginated sends a successful JSON response with data and pagination metadata.
func Paginated(w http.ResponseWriter, data interface{}, meta model.Pagination) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(model.APIResponse{
		Success: true,
		Data:    data,
		Meta:    &meta,
	})
}

// Error sends a JSON error response with the given HTTP status code.
func Error(w http.ResponseWriter, status int, msg string) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(model.APIResponse{
		Success: false,
		Error:   msg,
	})
}
