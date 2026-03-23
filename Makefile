.PHONY: run build db-setup db-seed db-reset test clean

run:
	go run ./backend/cmd/server/main.go

build:
	go build -o bin/server ./backend/cmd/server/main.go

db-setup:
	 mysql -u root -p$(DB_PASSWORD) < sql/001_schema.sql

db-seed:
	 mysql -u root -p$(DB_PASSWORD) village_twin < sql/002_seed.sql

db-reset: db-setup db-seed

test:
	go test ./...

clean:
	rm -rf bin/
