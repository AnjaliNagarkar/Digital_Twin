package handler

import (
	"log/slog"
	"net/http"

	"village-twin/internal/service"
	"village-twin/pkg/respond"
)

// InsightHandler handles HTTP requests for insight/analytics endpoints.
type InsightHandler struct {
	svc service.InsightService
}

// NewInsightHandler creates a new InsightHandler.
func NewInsightHandler(svc service.InsightService) *InsightHandler {
	return &InsightHandler{svc: svc}
}

// Governance handles GET /api/v1/insights/governance
func (h *InsightHandler) Governance(w http.ResponseWriter, r *http.Request) {
	data, err := h.svc.Governance(r.Context())
	if err != nil {
		slog.Error("governance insight failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to compute governance insights")
		return
	}
	respond.OK(w, data)
}

// Agriculture handles GET /api/v1/insights/agriculture
func (h *InsightHandler) Agriculture(w http.ResponseWriter, r *http.Request) {
	data, err := h.svc.Agriculture(r.Context())
	if err != nil {
		slog.Error("agriculture insight failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to compute agriculture insights")
		return
	}
	respond.OK(w, data)
}

// Welfare handles GET /api/v1/insights/welfare
func (h *InsightHandler) Welfare(w http.ResponseWriter, r *http.Request) {
	data, err := h.svc.Welfare(r.Context())
	if err != nil {
		slog.Error("welfare insight failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to compute welfare insights")
		return
	}
	respond.OK(w, data)
}

// Geo handles GET /api/v1/insights/geo?grid_size=0.001
func (h *InsightHandler) Geo(w http.ResponseWriter, r *http.Request) {
	gridSize := parseFloatDefault(r, "grid_size", 0.001)

	data, err := h.svc.Geo(r.Context(), gridSize)
	if err != nil {
		slog.Error("geo insight failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to compute geo insights")
		return
	}
	respond.OK(w, data)
}
