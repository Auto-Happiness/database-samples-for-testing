#!/bin/bash
# Quick Start Script for MSSQL Silog Database
# This script helps you get started with the Docker setup

echo ""
echo "========================================"
echo "Orcha Enterprise ERP - Quick Start"
echo "========================================"
echo ""

echo "Checking if Docker is running..."
if ! docker ps >/dev/null 2>&1; then
    echo "ERROR: Docker is not running. Please start Docker Desktop and try again."
    exit 1
fi

echo "Docker is running. Starting the database..."
echo ""

cd "$(dirname "$0")"

docker-compose up -d

echo ""
echo "========================================"
echo "Database is starting..."
echo "========================================"
echo ""
echo "Please wait 60 seconds for the database to fully initialize."
echo ""

echo "Connection Details:"
echo "  Server: localhost,1435"
echo "  Username: sa"
echo "  Password: OrchaAgentOS!2025"
echo "  Database: erp"
echo ""

echo "To check the status:"
echo "  docker-compose logs -f mssql"
echo ""

echo "To stop the database:"
echo "  docker-compose down"
echo ""

echo "To stop and remove all data:"
echo "  docker-compose down -v"
echo ""

sleep 5

echo ""
echo "Starting logs..."
docker-compose logs -f mssql
