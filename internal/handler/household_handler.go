package handler

import (
	"log/slog"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"village-twin/internal/model"
	"village-twin/internal/service"
	"village-twin/pkg/respond"
)

// HouseholdHandler handles HTTP requests for household endpoints.
type HouseholdHandler struct {
	svc service.HouseholdService
}

// NewHouseholdHandler creates a new HouseholdHandler.
func NewHouseholdHandler(svc service.HouseholdService) *HouseholdHandler {
	return &HouseholdHandler{svc: svc}
}

// ListHouses handles GET /api/v1/houses with filters and pagination.
//
// Query params: bpl, toilet, electricity, water, ward, scheme, crop,
//
//	min_lat, max_lat, min_lng, max_lng, page, page_size
func (h *HouseholdHandler) ListHouses(w http.ResponseWriter, r *http.Request) {
	f := model.HouseListFilter{
		BPL:            parseBoolParam(r, "bpl"),
		HasToilet:      parseBoolParam(r, "toilet"),
		HasElectricity: parseBoolParam(r, "electricity"),
		HasWaterSupply: parseBoolParam(r, "water"),
		WardNo:         parseIntParam(r, "ward"),
		SchemeCode:     r.URL.Query().Get("scheme"),
		CropType:       r.URL.Query().Get("crop"),
		MinLat:         parseFloatParam(r, "min_lat"),
		MaxLat:         parseFloatParam(r, "max_lat"),
		MinLng:         parseFloatParam(r, "min_lng"),
		MaxLng:         parseFloatParam(r, "max_lng"),
		Page:           parseIntDefault(r, "page", 1),
		PageSize:       parseIntDefault(r, "page_size", 20),
	}

	houses, total, err := h.svc.List(r.Context(), f)
	if err != nil {
		slog.Error("list houses failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to list houses")
		return
	}

	// Ensure we return empty array instead of null
	if houses == nil {
		houses = []model.Household{}
	}

	totalPages := total / f.PageSize
	if total%f.PageSize > 0 {
		totalPages++
	}

	respond.Paginated(w, houses, model.Pagination{
		Page:       f.Page,
		PageSize:   f.PageSize,
		Total:      total,
		TotalPages: totalPages,
	})
}

// GetHouse handles GET /api/v1/houses/{id} — full detail with nested data.
func (h *HouseholdHandler) GetHouse(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.ParseInt(idStr, 10, 64)
	if err != nil {
		respond.Error(w, http.StatusBadRequest, "invalid household id")
		return
	}

	house, err := h.svc.GetByID(r.Context(), id)
	if err != nil {
		slog.Error("get house failed", "error", err, "id", id)
		respond.Error(w, http.StatusInternalServerError, "failed to fetch household")
		return
	}
	if house == nil {
		respond.Error(w, http.StatusNotFound, "household not found")
		return
	}

	respond.OK(w, house)
}

// GetStats handles GET /api/v1/stats — summary statistics.
func (h *HouseholdHandler) GetStats(w http.ResponseWriter, r *http.Request) {
	stats, err := h.svc.GetStats(r.Context())
	if err != nil {
		slog.Error("get stats failed", "error", err)
		respond.Error(w, http.StatusInternalServerError, "failed to fetch stats")
		return
	}
	respond.OK(w, stats)
}
