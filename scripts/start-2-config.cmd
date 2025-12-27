@echo off
echo ========================================
echo   D?MARRAGE CONFIG SERVICE
echo ========================================
cd config-service
echo D?marrer sur port 8888...
echo.
mvn spring-boot:run
pause
