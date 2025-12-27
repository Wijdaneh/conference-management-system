@echo off
echo ========================================
echo   D?MARRAGE KEYNOTE SERVICE (H2)
echo ========================================
cd keynote-service
echo D?marrer sur port 8081 (H2)...
echo.
mvn spring-boot:run
pause
