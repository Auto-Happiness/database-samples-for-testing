#!/bin/bash

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for it to be ready
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "OrchaPassword123!" -Q "SELECT 1" &>/dev/null; do
    sleep 2
done

# Run the seed script
echo "Running seed script..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "OrchaPassword123!" -i /usr/config/seed.sql

# Keep the container running
wait
