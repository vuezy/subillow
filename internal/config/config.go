package config

import (
	"errors"
	"log"
	"os"

	"github.com/joho/godotenv"
)

type Config struct {
	databaseURL string
}

func Load() *Config {
	if err := godotenv.Load(".env"); err != nil {
		if !errors.Is(err, os.ErrNotExist) {
			log.Printf("warning: failed to load .env file: %v", err)
		}
	}

	return &Config{
		databaseURL: os.Getenv("DATABASE_URL"),
	}
}

func (cfg *Config) DatabaseURL() string {
	return cfg.databaseURL
}
