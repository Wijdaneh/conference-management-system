@echo off
echo ========================================
echo   D?MARRAGE CONFERENCE SERVICE (H2)
echo ========================================
cd conference-service
echo D?marrer sur port 8082 (H2)...
echo.
mvn spring-boot:run
pause
