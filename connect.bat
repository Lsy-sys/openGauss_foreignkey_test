@echo off
echo ========================================
echo Connect to openGauss Database
echo ========================================
echo.

echo Checking if Docker is running...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running or not installed
    pause
    exit /b 1
)

echo Checking all container status...
docker ps -a --filter name=opengauss

echo.
echo Checking if openGauss container is running...
docker ps --filter name=opengauss_experiment --format "{{.Names}}\t{{.Status}}" | findstr "opengauss_experiment" >nul
if %errorlevel% neq 0 (
    echo ERROR: openGauss container is not running
    echo Please run start.bat first to start the database
    echo.
    echo Current running containers:
    docker ps --format "{{.Names}}\t{{.Status}}"
    pause
    exit /b 1
)

echo Container is running, attempting to connect...
echo Password: Enmo@123
echo.

echo Waiting 3 seconds before connecting...
timeout /t 3 /nobreak >nul

echo Connecting to database...
docker exec -it opengauss_experiment /usr/local/opengauss/bin/gsql -d foreign_key_experiment -U gaussdb -W Enmo@123

if %errorlevel% neq 0 (
    echo.
    echo Connection failed, trying alternative methods...
    echo 1. Check container logs:
    docker logs opengauss_experiment
    echo.
    echo 2. Try to enter container directly:
    docker exec -it opengauss_experiment bash
    pause
)
