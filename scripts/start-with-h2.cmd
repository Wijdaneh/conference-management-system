@echo off
echo ========================================
echo   D?MARRAGE CONFERENCE MANAGEMENT
echo   (Mode H2 - Base en m?moire)
echo ========================================
echo.
echo ??  Les donn?es seront perdues au red?marrage
echo.

echo [1/5] D?marrer Discovery Service (Eureka)...
start "Discovery Service" cmd /k "cd discovery-service && mvn spring-boot:run"
echo Attente 20 secondes...
timeout /t 20 /nobreak >nul

echo.
echo [2/5] D?marrer Config Service...
start "Config Service" cmd /k "cd config-service && mvn spring-boot:run"
echo Attente 15 secondes...
timeout /t 15 /nobreak >nul

echo.
echo [3/5] D?marrer Conference Service (H2)...
start "Conference Service" cmd /k "cd conference-service && mvn spring-boot:run"
echo Attente 10 secondes...
timeout /t 10 /nobreak >nul

echo.
echo [4/5] D?marrer Keynote Service (H2)...
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
echo ?? Commandes de test :
echo curl http://localhost:8082/api/conferences
echo curl http://localhost:8081/api/keynotes
echo.
echo ??  IMPORTANT :
echo 1. Fermez d'abord les services Discovery et Config s'ils tournent d?j?
echo 2. Ce script utilisera H2 au lieu de PostgreSQL
echo.
pause
