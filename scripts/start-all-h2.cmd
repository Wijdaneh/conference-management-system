@echo off
echo ========================================
echo   D?MARRAGE CONFERENCE MANAGEMENT
echo   (Mode H2 - Base en m?moire)
echo ========================================
echo.

echo ??  Fermez d'abord les services existants (Ctrl+C dans chaque fen?tre)
echo.

set /p continue="Continuer? (O/N): "
if /i not "%continue%"=="O" (
    echo Arr?t.
    pause
    exit /b 0
)

echo.
echo [1/5] D?marrer Discovery Service (Eureka)...
start "Discovery Service" cmd /k "cd discovery-service && mvn spring-boot:run"
echo Attente 25 secondes que Eureka d?marre...
timeout /t 25 /nobreak >nul

echo.
echo [2/5] D?marrer Config Service...
start "Config Service" cmd /k "cd config-service && mvn spring-boot:run"
echo Attente 20 secondes...
timeout /t 20 /nobreak >nul

echo.
echo [3/5] D?marrer Conference Service...
start "Conference Service" cmd /k "cd conference-service && mvn spring-boot:run"
echo Attente 15 secondes...
timeout /t 15 /nobreak >nul

echo.
echo [4/5] D?marrer Keynote Service...
start "Keynote Service" cmd /k "cd keynote-service && mvn spring-boot:run"
echo Attente 10 secondes...
timeout /t 10 /nobreak >nul

echo.
echo [5/5] D?marrer Gateway Service...
start "Gateway Service" cmd /k "cd gateway-service && mvn spring-boot:run"

echo.
echo ========================================
echo   SERVICES D?MARR?S !
echo ========================================
echo.
echo ? Tous les services sont en cours de d?marrage
echo.
echo ?? URLs d'acc?s :
echo - Eureka Dashboard : http://localhost:8761
echo - Config Server    : http://localhost:8888
echo - API Gateway      : http://localhost:8080
echo - Conference API   : http://localhost:8082
echo - Keynote API      : http://localhost:8081
echo - H2 Console (Conf): http://localhost:8082/h2-console
echo - H2 Console (Key) : http://localhost:8081/h2-console
echo.
echo ?? Connexion H2 :
echo - URL JDBC: jdbc:h2:mem:conferencedb (ou keynotedb)
echo - Utilisateur: sa
echo - Mot de passe: (vide)
echo.
echo ?? Commandes de test (PowerShell) :
echo curl http://localhost:8082/api/conferences
echo curl http://localhost:8081/api/keynotes
echo curl http://localhost:8080/actuator/health
echo.
echo ? Attendez 1-2 minutes que tous les services soient compl?tement d?marr?s
echo    puis v?rifiez http://localhost:8761 pour voir les services enregistr?s
echo.
pause
