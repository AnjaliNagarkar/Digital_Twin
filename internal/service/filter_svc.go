package service

import (
	"context"

	"village-twin/internal/model"
	"village-twin/internal/repository"
)

// FilterService provides filter dropdown options.
type FilterService interface {
	GetFilters(ctx context.Context) (*model.FilterOptions, error)
}

type filterSvc struct {
	repo repository.FilterRepository
}

// NewFilterService creates a new FilterService.
func NewFilterService(repo repository.FilterRepository) FilterService {
	return &filterSvc{repo: repo}
}

func (s *filterSvc) GetFilters(ctx context.Context) (*model.FilterOptions, error) {
	return s.repo.GetFilterOptions(ctx)
}
