package main

import (
	"context"
	"log"

	"github.com/jackc/pgx/v5"
	"github.com/vuezy/subillow/internal/config"
	"github.com/vuezy/subillow/internal/db/sqlc"
)

func run() error {
	cfg := config.Load()
	ctx := context.Background()

	conn, err := pgx.Connect(ctx, cfg.DatabaseURL())
	if err != nil {
		return err
	}
	defer conn.Close(ctx)

	queries := sqlc.New(conn)

	users, err := queries.GetUsers(ctx)
	if err != nil {
		return err
	}
	log.Println(users)
	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
