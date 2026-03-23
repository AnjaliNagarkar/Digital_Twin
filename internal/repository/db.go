package repository

import (
	"database/sql"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

// NewDB opens a MySQL connection pool with production-tuned settings.
func NewDB(dsn string) (*sql.DB, error) {
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, err
	}

	// Connection pool tuning
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(10)
	db.SetConnMaxLifetime(5 * time.Minute)
	db.SetConnMaxIdleTime(2 * time.Minute)

	if err := db.Ping(); err != nil {
		return nil, err
	}
	return db, nil
}
