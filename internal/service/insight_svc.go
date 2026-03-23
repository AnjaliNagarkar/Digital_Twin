package service

import (
	"context"

	"village-twin/internal/model"
	"village-twin/internal/repository"
)

// InsightService orchestrates insight/analytics queries.
type InsightService interface {
	Governance(ctx context.Context) (*model.GovernanceInsight, error)
	Agriculture(ctx context.Context) (*model.AgriInsight, error)
	Welfare(ctx context.Context) (*model.WelfareInsight, error)
	Geo(ctx context.Context, gridSize float64) (*model.GeoInsight, error)
}

type insightSvc struct {
	repo repository.InsightRepository
}

// NewInsightService creates a new InsightService.
func NewInsightService(repo repository.InsightRepository) InsightService {
	return &insightSvc{repo: repo}
}

func (s *insightSvc) Governance(ctx context.Context) (*model.GovernanceInsight, error) {
	return s.repo.GovernanceGaps(ctx)
}

func (s *insightSvc) Agriculture(ctx context.Context) (*model.AgriInsight, error) {
	return s.repo.AgricultureAnalysis(ctx)
}

func (s *insightSvc) Welfare(ctx context.Context) (*model.WelfareInsight, error) {
	return s.repo.WelfareCoverage(ctx)
}

func (s *insightSvc) Geo(ctx context.Context, gridSize float64) (*model.GeoInsight, error) {
	if gridSize <= 0 {
		gridSize = 0.001 // ~111m grid cells
	}
	return s.repo.GeoClustering(ctx, gridSize)
}
