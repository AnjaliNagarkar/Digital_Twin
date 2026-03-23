package service

import (
	"context"
	"fmt"

	"village-twin/internal/model"
	"village-twin/internal/repository"
)

// HouseholdService handles business logic for household operations.
type HouseholdService interface {
	List(ctx context.Context, f model.HouseListFilter) ([]model.Household, int, error)
	GetByID(ctx context.Context, id int64) (*model.Household, error)
	GetStats(ctx context.Context) (*model.Stats, error)
}

type householdSvc struct {
	repo repository.HouseholdRepository
}

// NewHouseholdService creates a new HouseholdService.
func NewHouseholdService(repo repository.HouseholdRepository) HouseholdService {
	return &householdSvc{repo: repo}
}

func (s *householdSvc) List(ctx context.Context, f model.HouseListFilter) ([]model.Household, int, error) {
	// Apply defaults
	if f.Page < 1 {
		f.Page = 1
	}
	if f.PageSize < 1 || f.PageSize > 100 {
		f.PageSize = 20
	}
	return s.repo.List(ctx, f)
}

func (s *householdSvc) GetByID(ctx context.Context, id int64) (*model.Household, error) {
	h, err := s.repo.GetByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("getting household: %w", err)
	}
	if h == nil {
		return nil, nil
	}

	// Fetch all related data in parallel could be done here,
	// but for simplicity we fetch sequentially — MySQL handles it fine for single-household detail.
	h.Members, err = s.repo.GetMembers(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("getting members: %w", err)
	}

	h.Agriculture, err = s.repo.GetAgriculture(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("getting agriculture: %w", err)
	}

	h.Schemes, err = s.repo.GetSchemes(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("getting schemes: %w", err)
	}

	h.Assets, err = s.repo.GetAssets(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("getting assets: %w", err)
	}

	return h, nil
}

func (s *householdSvc) GetStats(ctx context.Context) (*model.Stats, error) {
	return s.repo.GetStats(ctx)
}
