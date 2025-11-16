@echo off
echo === LambdaTest SmartUI Test Runner ===
echo.

REM Set environment variables
set LT_USERNAME=samuelemediong45
set LT_ACCESS_KEY=LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing

echo Environment variables set
echo   LT_USERNAME: %LT_USERNAME%
echo   PROJECT_TOKEN: %PROJECT_TOKEN:~0,20%...
echo.

echo Checking if React app is running on http://localhost:3000...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:3000' -TimeoutSec 3 -UseBasicParsing -ErrorAction Stop; if ($response.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }"

if %ERRORLEVEL% EQU 0 (
    echo React app is running!
    echo.
    echo === Running SmartUI Tests ===
    echo.
    REM Pass environment variables to npm script
    set LT_USERNAME=%LT_USERNAME%
    set LT_ACCESS_KEY=%LT_ACCESS_KEY%
    set PROJECT_TOKEN=%PROJECT_TOKEN%
    call npm run test:smartui
    echo.
    echo === Test Execution Complete ===
    echo Check your SmartUI dashboard for results:
    echo https://smartui.lambdatest.com
) else (
    echo React app is NOT running
    echo.
    echo Please start the React app first:
    echo   1. Open a NEW terminal window
    echo   2. Navigate to: %CD%
    echo   3. Run: npm start
    echo   4. Wait for "Local: http://localhost:3000" message
    echo   5. Then run this script again: run-smartui-tests.bat
    echo.
    pause
)

