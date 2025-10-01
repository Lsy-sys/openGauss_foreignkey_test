@echo off
echo ========================================
echo Stop openGauss Database
echo ========================================
echo.

echo Stopping and removing containers...
docker-compose down

echo.
echo Cleanup completed!
echo ========================================
pause
