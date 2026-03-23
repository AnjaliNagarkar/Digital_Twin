package config

import (
	"os"
	"strings"
)

// Config holds all application configuration loaded from environment variables.
type Config struct {
	Port        string
	DBHost      string
	DBPort      string
	DBUser      string
	DBPassword  string
	DBName      string
	CORSOrigins []string
}

// Load reads configuration from environment variables with sensible defaults.
func Load() *Config {
	return &Config{
		Port:        envOrDefault("PORT", "8080"),
		DBHost:      envOrDefault("DB_HOST", "127.0.0.1"),
		DBPort:      envOrDefault("DB_PORT", "3306"),
		DBUser:      envOrDefault("DB_USER", "root"),
		DBPassword:  envOrDefault("DB_PASSWORD", ""),
		DBName:      envOrDefault("DB_NAME", "village_twin"),
		CORSOrigins: strings.Split(envOrDefault("CORS_ORIGINS", "http://localhost:3000,http://localhost:5173"), ","),
	}
}

// DSN returns a MySQL Data Source Name string for go-sql-driver/mysql.
func (c *Config) DSN() string {
	return c.DBUser + ":" + c.DBPassword +
		"@tcp(" + c.DBHost + ":" + c.DBPort + ")/" +
		c.DBName + "?parseTime=true&charset=utf8mb4&collation=utf8mb4_unicode_ci"
}

func envOrDefault(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
