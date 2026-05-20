param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("up", "down", "status")]
    [string]$Action = "up"
)

$services = @("customer", "items", "order", "payments", "reviews")
$basePath = $PSScriptRoot

foreach ($service in $services) {
    $path = Join-Path $basePath $service
    Write-Host "--- Processing Service: [$service] ---" -ForegroundColor Cyan
    
    if (Test-Path $path) {
        Push-Location $path
        try {
            if ($Action -eq "up") {
                docker-compose up -d
            } elseif ($Action -eq "down") {
                docker-compose down
            } elseif ($Action -eq "status") {
                docker-compose ps
            }
        } finally {
            Pop-Location
        }
    } else {
        Write-Warning "Path not found: $path"
    }
    Write-Host ""
}

if ($Action -eq "up") {
    Write-Host "All databases are starting up!" -ForegroundColor Green
    Write-Host "Postgres (Customer): localhost:5434"
    Write-Host "Postgres (Items):    localhost:5433"
    Write-Host "MySQL (Orders):      localhost:3307"
    Write-Host "MySQL (Payments):    localhost:3308"
    Write-Host "Postgres (Reviews):  localhost:5435"
}

