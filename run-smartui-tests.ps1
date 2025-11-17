# SmartUI Test Runner Script
# This script sets up environment variables and runs SmartUI tests

Write-Host "=== LambdaTest SmartUI Test Runner ===" -ForegroundColor Cyan
Write-Host ""

# Set environment variables
$env:LT_USERNAME = "samuelemediong45"
$env:LT_ACCESS_KEY = "LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB"
$env:PROJECT_TOKEN = "2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing"

Write-Host "Environment variables set" -ForegroundColor Green
Write-Host "  LT_USERNAME: $env:LT_USERNAME" -ForegroundColor Gray
Write-Host "  PROJECT_TOKEN: $($env:PROJECT_TOKEN.Substring(0, 20))..." -ForegroundColor Gray
Write-Host ""

# Check if React app is running
Write-Host "Checking if React app is running on http://localhost:3000..." -ForegroundColor Yellow
$isRunning = $false

try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 3 -UseBasicParsing -ErrorAction Stop
    if ($response.StatusCode -eq 200) {
        $isRunning = $true
        Write-Host "React app is running!" -ForegroundColor Green
    }
}
catch {
    Write-Host "React app is NOT running" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please start the React app first:" -ForegroundColor Yellow
    Write-Host "  1. Open a NEW terminal window" -ForegroundColor White
    Write-Host "  2. Navigate to: $PWD" -ForegroundColor White
    Write-Host "  3. Run: npm start" -ForegroundColor White
    Write-Host "  4. Wait for 'Local: http://localhost:3000' message" -ForegroundColor White
    Write-Host "  5. Then run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "Starting React app in new window..." -ForegroundColor Yellow
    
    $scriptPath = $PWD.Path
    $command = "cd '$scriptPath'; Write-Host 'Starting React app...' -ForegroundColor Cyan; npm start"
    Start-Process powershell -ArgumentList "-NoExit", "-Command", $command -WindowStyle Normal
    
    Write-Host ""
    Write-Host "Waiting for React app to start (this may take 30-60 seconds)..." -ForegroundColor Yellow
    Write-Host "Please wait for 'Local: http://localhost:3000' in the new window" -ForegroundColor Yellow
    
    # Wait for app to start
    $maxWait = 60
    $waited = 0
    while ($waited -lt $maxWait) {
        Start-Sleep -Seconds 2
        $waited += 2
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 2 -UseBasicParsing -ErrorAction Stop
            if ($response.StatusCode -eq 200) {
                $isRunning = $true
                Write-Host ""
                Write-Host "React app is now running!" -ForegroundColor Green
                break
            }
        }
        catch {
            Write-Host "." -NoNewline -ForegroundColor Gray
        }
    }
    Write-Host ""
}

if (-not $isRunning) {
    Write-Host ""
    Write-Host "React app is still not accessible" -ForegroundColor Red
    Write-Host "Please start it manually and try again" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To start manually:" -ForegroundColor Cyan
    Write-Host "  1. Open a new terminal" -ForegroundColor White
    Write-Host "  2. Run: cd $PWD" -ForegroundColor White
    Write-Host "  3. Run: npm start" -ForegroundColor White
    Write-Host "  4. Wait for app to start, then run this script again" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "=== Running SmartUI Tests ===" -ForegroundColor Cyan
Write-Host ""

# Run SmartUI tests
npm run test:smartui

Write-Host ""
Write-Host "=== Test Execution Complete ===" -ForegroundColor Cyan
Write-Host "Check your SmartUI dashboard for results:" -ForegroundColor Yellow
Write-Host "https://smartui.lambdatest.com" -ForegroundColor Cyan
