$services = @("customer", "items", "order", "payments", "reviews")
$basePath = $PSScriptRoot

foreach ($service in $services) {
    $path = Join-Path $basePath $service
    Write-Host "--- Stopping Service: [$service] ---" -ForegroundColor Yellow
    
    if (Test-Path $path) {
        Push-Location $path
        try {
            docker-compose down
        } finally {
            Pop-Location
        }
    }
    Write-Host ""
}

Write-Host "All multi-database services have been stopped." -ForegroundColor Green

