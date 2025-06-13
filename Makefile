postgres:
	docker run --name my-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres
createdb:
	docker exec -it my-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb sqlc migrateup migratedown
# This Makefile provides commands to manage a PostgreSQL database in a Docker container.