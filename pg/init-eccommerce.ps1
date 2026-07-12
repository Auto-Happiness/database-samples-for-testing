Param()

Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $here
try {
    if (Test-Path .\data) {
        $backup = "data_backup_{0:yyyyMMddHHmmss}" -f (Get-Date)
        Write-Host "Backing up existing data directory to $backup"
        Rename-Item -Path .\data -NewName $backup
    }

    Write-Host 'Stopping existing Postgres container if present...'
    docker compose down -v 2>$null | Out-Null

    Write-Host 'Starting PostgreSQL container...'
    docker compose up -d

    Write-Host 'Waiting for PostgreSQL to become ready...'
    $ready = $false
    for ($i = 0; $i -lt 60; $i++) {
        try {
            docker exec orcha-postgres pg_isready -U orcha -d postgres | Out-Null
            $ready = $true
            break
        } catch {
            Start-Sleep -Seconds 1
        }
    }

    if (-not $ready) {
        throw 'PostgreSQL did not become ready within 60 seconds.'
    }

    Write-Host 'Checking for the eccommerce database...'
    $exists = docker exec orcha-postgres psql -U orcha -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='eccommerce';"
    if ($exists.Trim() -ne '1') {
        Write-Host 'Creating eccommerce database...'
        docker exec orcha-postgres psql -U orcha -d postgres -v ON_ERROR_STOP=1 -c "CREATE DATABASE eccommerce OWNER orcha;"
    } else {
        Write-Host 'eccommerce database already exists.'
    }

    Write-Host 'Checking if eccommerce already has tables...'
    $tableCount = docker exec orcha-postgres psql -U orcha -d eccommerce -tAc "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';"
    if ([int]$tableCount -eq 0) {
        Write-Host 'Applying schema...'
        docker exec orcha-postgres psql -U orcha -d eccommerce -v ON_ERROR_STOP=1 -f /docker-entrypoint-initdb.d/001-eccom.sql

        Write-Host 'Applying seed data...'
        docker exec orcha-postgres psql -U orcha -d eccommerce -v ON_ERROR_STOP=1 -f /docker-entrypoint-initdb.d/002-seed.sql
    } else {
        Write-Host 'Schema already exists in eccommerce. Skipping schema/seed execution.'
    }

    Write-Host 'Done. eccommerce database is ready.'
} finally {
    Pop-Location
}
