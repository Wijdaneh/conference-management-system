@echo off
echo ========================================
echo   D?MARRAGE DISCOVERY SERVICE
echo ========================================
cd discovery-service
echo D?marrer sur port 8761...
echo.
mvn spring-boot:run
pause
