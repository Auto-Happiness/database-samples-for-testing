# Script to create and initialize the tapalord database in Docker SQL Server
# Run this after: docker-compose up -d

param(
    [string]$Server = "localhost",
    [int]$Port = 1433,
    [string]$Username = "sa",
    [string]$Password = "OrchaAgentOS!2025",
    [string]$DatabaseName = "tapalord"
)

# Get the directory where this script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SqlFile = Join-Path $ScriptDir "tapalord.sql"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Tapalord Database Initialization Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if SQL file exists
if (-not (Test-Path $SqlFile)) {
    Write-Host "ERROR: SQL file not found at: $SqlFile" -ForegroundColor Red
    exit 1
}

# Connection string
$ConnectionString = "Server=$Server,$Port;User Id=$Username;Password=$Password;"

# Wait for SQL Server to be ready
Write-Host "Waiting for SQL Server to be ready at $Server`:$Port..." -ForegroundColor Yellow
$maxAttempts = 30
$attempt = 0
$ready = $false

while (-not $ready -and $attempt -lt $maxAttempts) {
    try {
        $connection = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)
        $connection.Open()
        $connection.Close()
        $ready = $true
        Write-Host "[+] SQL Server is ready!" -ForegroundColor Green
    }
    catch {
        $attempt++
        Write-Host "  Attempt $attempt/$maxAttempts - SQL Server not ready yet..." -ForegroundColor Gray
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    Write-Host "[-] ERROR: SQL Server failed to start within the expected time." -ForegroundColor Red
    exit 1
}

# Drop and recreate database
Write-Host ""
Write-Host "Dropping existing database (if it exists) and creating fresh..." -ForegroundColor Yellow

$dropDbQuery = "IF EXISTS (SELECT name FROM sys.databases WHERE name = '$DatabaseName') DROP DATABASE [$DatabaseName];"
$createDbQuery = "CREATE DATABASE [$DatabaseName];"

try {
    $connection = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)
    $connection.Open()
    $command = $connection.CreateCommand()
    $command.CommandText = $dropDbQuery
    $command.ExecuteNonQuery() | Out-Null
    $command.CommandText = $createDbQuery
    $command.ExecuteNonQuery() | Out-Null
    $connection.Close()
    Write-Host "[+] Database '$DatabaseName' ready" -ForegroundColor Green
}
catch {
    Write-Host "[-] ERROR creating database: $_" -ForegroundColor Red
    exit 1
}

# Execute the SQL initialization script
Write-Host ""
Write-Host "Running initialization script: $SqlFile..." -ForegroundColor Yellow

$dbConnectionString = "Server=$Server,$Port;User Id=$Username;Password=$Password;Database=$DatabaseName;"

try {
    $connection = New-Object System.Data.SqlClient.SqlConnection($dbConnectionString)
    $connection.Open()
    
    # Read and execute the SQL script
    $sqlScript = Get-Content -Path $SqlFile -Raw
    
    # Split by GO statements (common in SQL Server scripts)
    $batches = @()
    $currentBatch = @()
    
    foreach ($line in $sqlScript -split "`n") {
        if ($line -imatch '^\s*GO\s*$') {
            if ($currentBatch.Count -gt 0) {
                $batches += ($currentBatch -join "`n").Trim()
                $currentBatch = @()
            }
        } else {
            $currentBatch += $line
        }
    }
    
    # Don't forget the last batch
    if ($currentBatch.Count -gt 0) {
        $batches += ($currentBatch -join "`n").Trim()
    }
    
    # Filter out empty batches and execute
    foreach ($batch in $batches | Where-Object { $_.Trim() -ne "" }) {
        $command = $connection.CreateCommand()
        $command.CommandText = $batch
        $command.CommandTimeout = 300
        $command.ExecuteNonQuery() | Out-Null
    }
    
    $connection.Close()
    Write-Host "[+] Schema created successfully" -ForegroundColor Green
}
catch {
    Write-Host "[-] ERROR executing SQL script: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[+] Database initialization complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
