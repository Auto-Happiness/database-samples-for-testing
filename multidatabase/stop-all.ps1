$services = @("items", "order", "payment")
$basePath = "c:\repos\orcha-agent-os\datasamples\multidatabase"

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
