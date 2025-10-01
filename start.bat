@echo off
echo ========================================
echo openGauss Database Environment Startup
echo ========================================
echo.

echo Checking if Docker is running...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not running
    echo Please install Docker Desktop for Windows first
    pause
    exit /b 1
)

echo Docker is installed, starting openGauss...
echo.

echo Stopping and removing existing containers (if any)...
docker-compose down

echo Starting openGauss database...
docker-compose up -d

echo.
echo Waiting for database to start (about 30 seconds)...
timeout /t 30 /nobreak >nul

echo.
echo Checking container status...
docker-compose ps

echo.
echo ========================================
echo Environment startup completed!
echo ========================================
echo Database connection info:
echo - Host: localhost
echo - Port: 5432
echo - Username: gaussdb
echo - Password: Enmo@123
echo - Database: foreign_key_experiment
echo.
echo Connection command:
echo docker exec -it opengauss_experiment gsql -d foreign_key_experiment -U gaussdb -W Enmo@123
echo.
echo Run experiments: double-click run_tests.bat
echo ========================================
pause
