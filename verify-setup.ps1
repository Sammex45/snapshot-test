# Quick verification script for SmartUI setup
Write-Host "=== SmartUI Setup Verification ===" -ForegroundColor Cyan
Write-Host ""

# Check environment variables
$ltUsername = $env:LT_USERNAME
$ltAccessKey = $env:LT_ACCESS_KEY
$projectToken = $env:PROJECT_TOKEN

Write-Host "Environment Variables:" -ForegroundColor Yellow
if ($ltUsername) {
    Write-Host "  ✓ LT_USERNAME is set" -ForegroundColor Green
} else {
    Write-Host "  ✗ LT_USERNAME is NOT set" -ForegroundColor Red
}

if ($ltAccessKey) {
    Write-Host "  ✓ LT_ACCESS_KEY is set" -ForegroundColor Green
} else {
    Write-Host "  ✗ LT_ACCESS_KEY is NOT set" -ForegroundColor Red
}

if ($projectToken) {
    Write-Host "  ✓ PROJECT_TOKEN is set" -ForegroundColor Green
    Write-Host "    Token: $($projectToken.Substring(0, [Math]::Min(30, $projectToken.Length)))..." -ForegroundColor Gray
} else {
    Write-Host "  ✗ PROJECT_TOKEN is NOT set" -ForegroundColor Red
}

Write-Host ""
Write-Host "Configuration Files:" -ForegroundColor Yellow
if (Test-Path ".smartui.json") {
    Write-Host "  ✓ .smartui.json exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ .smartui.json NOT found" -ForegroundColor Red
}

if (Test-Path "src/lambdatest.spec.js") {
    Write-Host "  ✓ Test file exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ Test file NOT found" -ForegroundColor Red
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Start React app: npm start" -ForegroundColor White
Write-Host "  2. In another terminal, run: npm run test:smartui" -ForegroundColor White
Write-Host ""

if ($ltUsername -and $ltAccessKey -and $projectToken) {
    Write-Host "✓ All setup complete! Ready to run tests." -ForegroundColor Green
} else {
    Write-Host "✗ Please set missing environment variables" -ForegroundColor Red
}

