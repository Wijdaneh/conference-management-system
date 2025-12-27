@echo off
echo ========================================
echo   D?MARRAGE CONFERENCE MANAGEMENT
echo   (Mode sans Docker)
echo ========================================
echo.

echo [1/5] D?marrer PostgreSQL...
echo Note: Assurez-vous que PostgreSQL est install? et d?marr? sur le port 5432
echo.

echo [2/5] D?marrer Discovery Service (Eureka)...
start "Discovery Service" cmd /k "cd discovery-service && mvn spring-boot:run"
echo Attente de 15 secondes que Eureka d?marre...
timeout /t 15 /nobreak >nul

echo.
echo [3/5] D?marrer Config Service...
start "Config Service" cmd /k "cd config-service && mvn spring-boot:run"
echo Attente de 10 secondes...
timeout /t 10 /nobreak >nul

echo.
echo [4/5] D?marrer Keynote Service...
start "Keynote Service" cmd /k "cd keynote-service && mvn spring-boot:run"
echo Attente de 10 secondes...
timeout /t 10 /nobreak >nul

echo.
echo [5/5] D?marrer Conference Service...
start "Conference Service" cmd /k "cd conference-service && mvn spring-boot:run"
echo Attente de 10 secondes...
timeout /t 10 /nobreak >nul

echo.
echo [6/6] D?marrer Gateway Service...
start "Gateway Service" cmd /k "cd gateway-service && mvn spring-boot:run"

echo.
echo ========================================
echo   SERVICES D?MARR?S AVEC SUCC?S
echo ========================================
echo.
echo ?? URLs d'acc?s :
echo - Eureka Dashboard: http://localhost:8761
echo - Config Server:    http://localhost:8888
echo - Gateway:          http://localhost:8080
echo - Conference API:   http://localhost:8082
echo - Keynote API:      http://localhost:8081
echo.
echo ?? Commandes utiles :
echo - Arr?ter tous: Fermez les fen?tres de commande
echo - V?rifier: Acc?dez ? http://localhost:8761
echo.
echo ??  IMPORTANT : PostgreSQL doit ?tre d?marr? s?par?ment !
echo    Installation: https://www.postgresql.org/download/windows/
echo    Port par d?faut: 5432
echo.
pause
