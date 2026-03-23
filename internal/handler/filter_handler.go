package handler

import (
	"log/slog"
	"net/http"

	"village-twin/internal/service"
	"village-twin/pkg/respond"
)

// FilterHandler handles HTTP requests for filter dropdown options.
type FilterHandler struct {
	svc service.FilterService
}

// NewFilterHandler creates a new FilterHandler.
func NewFilterHandler(svc service.FilterService) *FilterHandler {
	return &FilterHandler{svc: svc}
}

// GetFilters handles GET /api/v1/filters
func (h *FilterHandler) GetFilters(w http.ResponseWriter, r *http.Request) {
	opts, err := h.svc.GetFilters(r.Context())
	if err != nil {
		slog.Error("get filters failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to fetch filter options")
		return
	}
	respond.OK(w, opts)
}
