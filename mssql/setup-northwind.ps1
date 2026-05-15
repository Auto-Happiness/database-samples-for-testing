# Wait for SQL Server to be ready
Write-Host "Waiting for SQL Server to start..."
$maxAttempts = 30
$attempt = 0
$ready = $false

while (-not $ready -and $attempt -lt $maxAttempts) {
    try {
        $result = docker exec orcha-mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "OrchaAgentOS!2025" -Q "SELECT 1" -t 1 -C 2>$null
        if ($LASTEXITCODE -eq 0) {
            $ready = $true
        }
    } catch { }
    
    if (-not $ready) {
        $attempt++
        Write-Host "Attempt $attempt/$maxAttempts - SQL Server is not ready yet..."
        Start-Sleep -Seconds 2
    }
}

if ($ready) {
    Write-Host "SQL Server is ready. Creating Northwind database..."
    docker exec orcha-mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "OrchaAgentOS!2025" -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Northwind') CREATE DATABASE Northwind" -C
    
    Write-Host "Importing Northwind data from instnwnd.sql..."
    docker exec orcha-mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "OrchaAgentOS!2025" -d Northwind -i /usr/src/app/instnwnd.sql -C
    
    Write-Host "`nNorthwind database setup complete!"
    Write-Host "Connection details:"
    Write-Host "  Engine:   MSSQL"
    Write-Host "  Host:     localhost"
    Write-Host "  Port:     1433"
    Write-Host "  User:     sa"
    Write-Host "  Password: OrchaAgentOS!2025"
    Write-Host "  Database: Northwind"
} else {
    Write-Error "SQL Server failed to start within the expected time."
}
