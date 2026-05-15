#!/bin/bash

# Variables
DB_NAME="erp"
# MSSQL_SA_PASSWORD is provided via environment

# Wait for SQL Server to be ready
echo "Waiting for SQL Server to start..."
max_attempts=30
attempt=0
ready=0

while [ $ready -eq 0 ] && [ $attempt -lt $max_attempts ]; do
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT 1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        ready=1
    else
        attempt=$((attempt + 1))
        echo "Attempt $attempt/$max_attempts - SQL Server is not ready yet..."
        sleep 2
    fi
done

if [ $ready -eq 1 ]; then
    echo "SQL Server is ready. Creating database and initializing schema..."
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '$DB_NAME') CREATE DATABASE $DB_NAME;"
    
    echo "Running initialization SQL script..."
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -d "$DB_NAME" -C -i "/usr/src/app/erp.sql"
    
    echo "Database initialization complete!"
else
    echo "ERROR: SQL Server failed to start within the expected time."
    exit 1
fi
