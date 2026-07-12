# PostgreSQL E-Commerce Sample

This directory contains a PostgreSQL Docker Compose setup for an e-commerce sample database.

## Database
- Database name: `eccommerce`
- User: `orcha`
- Password: `OrchaAgentOS!2025`

## Files
- `docker-compose.yml`: starts the PostgreSQL container and mounts the schema/seed SQL files.
- `eccommerce/eccom.sql`: creates the e-commerce schema.
- `eccommerce/seed.sql`: inserts sample data into the schema.
- `data/`: PostgreSQL data volume storage.

## Usage
1. Run `docker compose up -d` in this directory.
2. Connect to the database at `localhost:5432`.
3. Use the `eccommerce` database.
4. Or run `.
un-eccommerce-init.ps1` from PowerShell to start the container and initialize the database in one command.

## Notes
- The schema and seed data are mounted as read-only files.
- If the container already exists, use `docker compose down -v` first to reset the volume.
