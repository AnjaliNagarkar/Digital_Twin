package handler

import (
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
)

// SetupRouter creates and configures the chi router with all routes and middleware.
func SetupRouter(
	hh *HouseholdHandler,
	ih *InsightHandler,
	fh *FilterHandler,
	corsOrigins []string,
	webDir string,
) http.Handler {
	r := chi.NewRouter()

	// ─── Middleware ──────────────────────────────────────────
	r.Use(middleware.RequestID)
	r.Use(middleware.RealIP)
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)
	r.Use(middleware.Timeout(30 * time.Second))

	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   corsOrigins,
		AllowedMethods:   []string{"GET", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Content-Type"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: false,
		MaxAge:           300,
	}))

	// ─── Health check ───────────────────────────────────────
	r.Get("/health", func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(`{"status":"ok"}`))
	})

	// ─── API v1 ─────────────────────────────────────────────
	r.Route("/api/v1", func(r chi.Router) {
		// Households
		r.Get("/houses", hh.ListHouses)
		r.Get("/houses/{id}", hh.GetHouse)
		r.Get("/stats", hh.GetStats)

		// Insights
		r.Route("/insights", func(r chi.Router) {
			r.Get("/governance", ih.Governance)
			r.Get("/agriculture", ih.Agriculture)
			r.Get("/welfare", ih.Welfare)
			r.Get("/geo", ih.Geo)
		})

		// Filters
		r.Get("/filters", fh.GetFilters)
	})

	// ─── Serve web dashboard ────────────────────────────────
	if webDir != "" {
		fs := http.FileServer(http.Dir(webDir))
		r.Handle("/*", fs)
	}

	return r
}
