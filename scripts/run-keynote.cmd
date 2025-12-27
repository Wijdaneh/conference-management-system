@echo off
cd keynote-service
echo D?marrage de Keynote Service...
timeout /t 30 >nul
mvn spring-boot:run
pause
