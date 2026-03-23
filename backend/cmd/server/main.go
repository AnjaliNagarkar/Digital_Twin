package main

import (
	"log/slog"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"

	"village-twin/internal/config"
	"village-twin/internal/handler"
	"village-twin/internal/repository"
	"village-twin/internal/service"
)

func main() {
	// Load .env file if present (ignored if missing)
	_ = godotenv.Load()

	cfg := config.Load()

	slog.Info("connecting to database",
		"host", cfg.DBHost,
		"port", cfg.DBPort,
		"name", cfg.DBName,
	)

	// ─── Database ───────────────────────────────────────────
	db, err := repository.NewDB(cfg.DSN())
	if err != nil {
		slog.Error("failed to connect to database", "error", err)
		os.Exit(1)
	}
	defer db.Close()
	slog.Info("database connected successfully")

	// ─── Repositories ───────────────────────────────────────
	householdRepo := repository.NewHouseholdRepo(db)
	insightRepo := repository.NewInsightRepo(db)
	filterRepo := repository.NewFilterRepo(db)

	// ─── Services ───────────────────────────────────────────
	householdSvc := service.NewHouseholdService(householdRepo)
	insightSvc := service.NewInsightService(insightRepo)
	filterSvc := service.NewFilterService(filterRepo)

	// ─── Handlers ───────────────────────────────────────────
	hh := handler.NewHouseholdHandler(householdSvc)
	ih := handler.NewInsightHandler(insightSvc)
	fh := handler.NewFilterHandler(filterSvc)

	// ─── Router ─────────────────────────────────────────────
	webDir := "web" // serves ./web/index.html at http://localhost:PORT/
	router := handler.SetupRouter(hh, ih, fh, cfg.CORSOrigins, webDir)

	// ─── Server ─────────────────────────────────────────────
	srv := &http.Server{
		Addr:         ":" + cfg.Port,
		Handler:      router,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 30 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	slog.Info("server starting", "port", cfg.Port, "url", "http://localhost:"+cfg.Port)
	slog.Info("dashboard", "url", "http://localhost:"+cfg.Port+"/index.html")
	slog.Info("endpoints available",
		"houses", "GET /api/v1/houses",
		"detail", "GET /api/v1/houses/{id}",
		"stats", "GET /api/v1/stats",
		"governance", "GET /api/v1/insights/governance",
		"agriculture", "GET /api/v1/insights/agriculture",
		"welfare", "GET /api/v1/insights/welfare",
		"geo", "GET /api/v1/insights/geo",
		"filters", "GET /api/v1/filters",
	)

	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		slog.Error("server failed", "error", err)
		os.Exit(1)
	}
}
