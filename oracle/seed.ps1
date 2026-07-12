# seed.ps1 - PowerShell script to seed the Oracle Database

# 1. Determine script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if ([string]::IsNullOrEmpty($scriptDir)) {
    $scriptDir = Get-Location
}

# 2. Check if Docker is running
Write-Host "Checking if Docker is running..." -ForegroundColor Cyan
& docker info > $null 2>&1
if ($LastExitCode -ne 0) {
    Write-Error "Docker is not running or not in PATH. Please start Docker Desktop and try again."
    exit 1
}

# 3. Check if oracle-free container is running, if not start it
$containerName = "oracle-free"
$containerStatus = docker ps --filter "name=$containerName" --format "{{.Status}}"

if ([string]::IsNullOrEmpty($containerStatus)) {
    Write-Host "Container '$containerName' is not running. Starting it via docker compose..." -ForegroundColor Yellow
    Push-Location $scriptDir
    docker compose up -d
    Pop-Location
} else {
    Write-Host "Container '$containerName' is already running." -ForegroundColor Green
}

# 4. Wait for container to be healthy
Write-Host "Waiting for Oracle database to be healthy (this can take a few minutes if starting for the first time)..." -ForegroundColor Cyan
$timeoutSec = 300
$elapsedSec = 0
$checkIntervalSec = 5

while ($true) {
    $health = docker inspect -f "{{.State.Health.Status}}" $containerName 2>$null
    if ($health -eq "healthy") {
        Write-Host "`nOracle Database is healthy!" -ForegroundColor Green
        break
    }
    
    # Also check if it's already ready in logs to be safe
    $logs = docker logs --tail 50 $containerName 2>$null
    if ($logs -match "DATABASE IS READY TO USE!") {
        Write-Host "`nOracle Database is ready!" -ForegroundColor Green
        break
    }
    
    if ($elapsedSec -ge $timeoutSec) {
        Write-Error "Timeout waiting for Oracle database to start."
        exit 1
    }
    
    Write-Host -NoNewline "."
    Start-Sleep -Seconds $checkIntervalSec
    $elapsedSec += $checkIntervalSec
}

# 5. Run the seeding script inside the container
Write-Host "Seeding the database..." -ForegroundColor Cyan
docker exec -i $containerName /bin/bash /opt/oracle/scripts/setup/001-setup.sh

if ($LastExitCode -eq 0) {
    Write-Host "`nDatabase seeded successfully!" -ForegroundColor Green
    
    Write-Host "`n==================================================" -ForegroundColor Yellow
    Write-Host "           ORACLE CONNECTION DETAILS" -ForegroundColor Yellow
    Write-Host "==================================================" -ForegroundColor Yellow
    Write-Host "  Host:             localhost"
    Write-Host "  Port:             1521"
    Write-Host "  Service Name:     FREEPDB1"
    Write-Host "  Connection URL:   jdbc:oracle:thin:@//localhost:1521/FREEPDB1"
    Write-Host "                    or: localhost:1521/FREEPDB1"
    Write-Host ""
    Write-Host "  Credentials:"
    Write-Host "  1. Admin User (SYSDBA):"
    Write-Host "     - Username:    SYS"
    Write-Host "     - Password:    oracle"
    Write-Host "     - Role:        SYSDBA"
    Write-Host "     - Command:     sqlplus sys/oracle@//localhost:1521/FREEPDB1 as sysdba"
    Write-Host ""
    Write-Host "  2. Sample Schema User (Contains all the Tables & Data):"
    Write-Host "     - Username:    MODELS_SCHEMA"
    Write-Host "     - Password:    models123"
    Write-Host "     - Schema:      MODELS_SCHEMA"
    Write-Host "     - Tables:      models, model_contacts, talents, occupation, education, earnings"
    Write-Host "     - Command:     sqlplus models_schema/models123@//localhost:1521/FREEPDB1"
    Write-Host ""
    Write-Host "  3. DBA User:"
    Write-Host "     - Username:    MODELS"
    Write-Host "     - Password:    models"
    Write-Host "     - Role:        DBA"
    Write-Host "     - Command:     sqlplus models/models@//localhost:1521/FREEPDB1"
    Write-Host "==================================================" -ForegroundColor Yellow
} else {
    Write-Error "Failed to seed the database."
    exit 1
}
