@echo off
cd conference-service
echo D?marrage de Conference Service...
timeout /t 20 >nul
mvn spring-boot:run
pause
