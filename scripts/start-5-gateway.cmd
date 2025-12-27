@echo off
echo ========================================
echo   D?MARRAGE GATEWAY SERVICE
echo ========================================
cd gateway-service
echo D?marrer sur port 8080...
echo.
mvn spring-boot:run
pause
