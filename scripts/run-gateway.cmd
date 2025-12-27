@echo off
cd gateway-service
echo D?marrage de Gateway Service...
timeout /t 40 >nul
mvn spring-boot:run
pause
