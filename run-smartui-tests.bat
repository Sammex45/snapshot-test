@REM @echo off
@REM echo === LambdaTest SmartUI Test Runner ===
@REM echo.

@REM REM Set environment variables
@REM set LT_USERNAME=samuelemediong45
@REM set LT_ACCESS_KEY=LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
@REM set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing

@REM echo Environment variables set
@REM echo   LT_USERNAME: %LT_USERNAME%
@REM echo   PROJECT_TOKEN: %PROJECT_TOKEN:~0,20%...
@REM echo.

@REM echo Checking if React app is running on http://localhost:3000...
@REM powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:3000' -TimeoutSec 3 -UseBasicParsing -ErrorAction Stop; if ($response.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }"

@REM if %ERRORLEVEL% EQU 0 (
@REM     echo React app is running!
@REM     echo.
@REM     echo === Running SmartUI Tests ===
@REM     echo.
@REM     REM Pass environment variables to npm script
@REM     set LT_USERNAME=%LT_USERNAME%
@REM     set LT_ACCESS_KEY=%LT_ACCESS_KEY%
@REM     set PROJECT_TOKEN=%PROJECT_TOKEN%
@REM     call npm run test:smartui
@REM     echo.
@REM     echo === Test Execution Complete ===
@REM     echo Check your SmartUI dashboard for results:
@REM     echo https://smartui.lambdatest.com
@REM ) else (
@REM     echo React app is NOT running
@REM     echo.
@REM     echo Please start the React app first:
@REM     echo   1. Open a NEW terminal window
@REM     echo   2. Navigate to: %CD%
@REM     echo   3. Run: npm start
@REM     echo   4. Wait for "Local: http://localhost:3000" message
@REM     echo   5. Then run this script again: run-smartui-tests.bat
@REM     echo.
@REM     pause
@REM )


@echo off
echo === LambdaTest SmartUI Test Runner ===
echo.

REM Load environment variables from .env file
if exist .env (
    echo Loading credentials from .env file...
    for /f "usebackq tokens=1,* delims==" %%a in (".env") do (
        if not "%%a"=="" if not "%%b"=="" (
            REM Skip comments
            echo %%a | findstr /b "#" >nul
            if errorlevel 1 (
                set %%a=%%b
            )
        )
    )
    echo Credentials loaded successfully.
) else (
    echo ERROR: .env file not found!
    echo Please copy .env.example to .env and add your credentials.
    exit /b 1
)

REM Validate credentials are set
if "%LT_USERNAME%"=="" (
    echo ERROR: LT_USERNAME not set in .env file
    exit /b 1
)
if "%LT_ACCESS_KEY%"=="" (
    echo ERROR: LT_ACCESS_KEY not set in .env file
    exit /b 1
)

echo.
echo Running SmartUI tests...
npm test

echo.
echo Tests completed.