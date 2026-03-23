package handler

import (
	"net/http"
	"strconv"
)

// parseBoolParam parses an optional boolean query parameter ("1"/"0" or "true"/"false").
func parseBoolParam(r *http.Request, key string) *bool {
	v := r.URL.Query().Get(key)
	if v == "" {
		return nil
	}
	b, err := strconv.ParseBool(v)
	if err != nil {
		// Try "1"/"0"
		if v == "1" {
			t := true
			return &t
		}
		if v == "0" {
			f := false
			return &f
		}
		return nil
	}
	return &b
}

// parseIntParam parses an optional integer query parameter.
func parseIntParam(r *http.Request, key string) *int {
	v := r.URL.Query().Get(key)
	if v == "" {
		return nil
	}
	i, err := strconv.Atoi(v)
	if err != nil {
		return nil
	}
	return &i
}

// parseIntDefault parses an integer query parameter with a default value.
func parseIntDefault(r *http.Request, key string, def int) int {
	v := r.URL.Query().Get(key)
	if v == "" {
		return def
	}
	i, err := strconv.Atoi(v)
	if err != nil {
		return def
	}
	return i
}

// parseFloatParam parses an optional float64 query parameter.
func parseFloatParam(r *http.Request, key string) *float64 {
	v := r.URL.Query().Get(key)
	if v == "" {
		return nil
	}
	f, err := strconv.ParseFloat(v, 64)
	if err != nil {
		return nil
	}
	return &f
}

// parseFloatDefault parses a float64 query parameter with a default value.
func parseFloatDefault(r *http.Request, key string, def float64) float64 {
	v := r.URL.Query().Get(key)
	if v == "" {
		return def
	}
	f, err := strconv.ParseFloat(v, 64)
	if err != nil {
		return def
	}
	return f
}
