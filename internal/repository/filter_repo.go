package repository

import (
	"context"
	"database/sql"
	"fmt"

	"village-twin/internal/model"
)

// FilterRepository provides distinct filter values for frontend dropdowns.
type FilterRepository interface {
	GetFilterOptions(ctx context.Context) (*model.FilterOptions, error)
}

type mysqlFilterRepo struct {
	db *sql.DB
}

// NewFilterRepo creates a MySQL-backed FilterRepository.
func NewFilterRepo(db *sql.DB) FilterRepository {
	return &mysqlFilterRepo{db: db}
}

func (r *mysqlFilterRepo) GetFilterOptions(ctx context.Context) (*model.FilterOptions, error) {
	f := &model.FilterOptions{
		BoolFilters: []string{"bpl", "toilet", "electricity", "water", "gas"},
	}

	var err error

	// Crop types
	f.CropTypes, err = r.stringList(ctx, "SELECT DISTINCT crop_type FROM agriculture ORDER BY crop_type")
	if err != nil {
		return nil, fmt.Errorf("filter_repo crop_types: %w", err)
	}

	// House types
	f.HouseTypes, err = r.stringList(ctx, "SELECT DISTINCT house_type FROM households ORDER BY house_type")
	if err != nil {
		return nil, fmt.Errorf("filter_repo house_types: %w", err)
	}

	// Irrigation types
	f.IrrigationTypes, err = r.stringList(ctx, "SELECT DISTINCT irrigation_type FROM agriculture ORDER BY irrigation_type")
	if err != nil {
		return nil, fmt.Errorf("filter_repo irrigation_types: %w", err)
	}

	// Ration cards
	f.RationCards, err = r.stringList(ctx, "SELECT DISTINCT ration_card FROM households ORDER BY ration_card")
	if err != nil {
		return nil, fmt.Errorf("filter_repo ration_cards: %w", err)
	}

	// Wards
	f.Wards, err = r.intList(ctx, "SELECT DISTINCT ward_no FROM households ORDER BY ward_no")
	if err != nil {
		return nil, fmt.Errorf("filter_repo wards: %w", err)
	}

	// Schemes
	schemeQ := "SELECT code, name FROM schemes ORDER BY name"
	rows, err := r.db.QueryContext(ctx, schemeQ)
	if err != nil {
		return nil, fmt.Errorf("filter_repo schemes: %w", err)
	}
	defer rows.Close()

	for rows.Next() {
		var s model.SchemeRef
		if err := rows.Scan(&s.Code, &s.Name); err != nil {
			return nil, fmt.Errorf("filter_repo schemes scan: %w", err)
		}
		f.Schemes = append(f.Schemes, s)
	}

	return f, rows.Err()
}

func (r *mysqlFilterRepo) stringList(ctx context.Context, q string) ([]string, error) {
	rows, err := r.db.QueryContext(ctx, q)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var result []string
	for rows.Next() {
		var v string
		if err := rows.Scan(&v); err != nil {
			return nil, err
		}
		result = append(result, v)
	}
	return result, rows.Err()
}

func (r *mysqlFilterRepo) intList(ctx context.Context, q string) ([]int, error) {
	rows, err := r.db.QueryContext(ctx, q)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var result []int
	for rows.Next() {
		var v int
		if err := rows.Scan(&v); err != nil {
			return nil, err
		}
		result = append(result, v)
	}
	return result, rows.Err()
}
