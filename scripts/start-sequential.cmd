@echo off
echo ========================================
echo   D?MARRAGE S?QUENTIEL DES SERVICES
echo ========================================
echo.

echo [1/5] D?marrer Discovery Service (Eureka)...
start "Discovery (8761)" start-1-discovery.cmd
echo Attente 35 secondes que Eureka d?marre compl?tement...
echo (Cette ?tape est critique - ne pas r?duire le temps d'attente)
timeout /t 35 /nobreak >nul

echo.
echo [2/5] D?marrer Config Service...
start "Config (8888)" start-2-config.cmd
echo Attente 30 secondes...
timeout /t 30 /nobreak >nul

echo.
echo [3/5] D?marrer Conference Service (H2)...
start "Conference (8082)" start-3-conference.cmd
echo Attente 25 secondes...
timeout /t 25 /nobreak >nul

echo.
echo [4/5] D?marrer Keynote Service (H2)...
start "Keynote (8081)" start-4-keynote.cmd
echo Attente 20 secondes...
timeout /t 20 /nobreak >nul

echo.
echo [5/5] D?marrer Gateway Service...
start "Gateway (8080)" start-5-gateway.cmd

echo.
echo ========================================
echo   D?MARRAGE INITI?
echo ========================================
echo.
echo ? Tous les services sont en cours de d?marrage
echo.
echo ? VEUILLEZ PATIENTER 2-3 MINUTES
echo    Les services Spring Boot mettent du temps ? d?marrer
echo.
echo ?? ?TAPES DE V?RIFICATION :
echo 1. Dans 1 minute : http://localhost:8761 (Eureka)
echo    ? Doit montrer DISCOVERY-SERVICE
echo.
echo 2. Dans 2 minutes : http://localhost:8761
echo    ? Doit montrer 2-3 services
echo.
echo 3. Dans 3 minutes : http://localhost:8761
echo    ? Doit montrer 4-5 services
echo.
echo 4. Test final : http://localhost:8080/actuator/health
echo    ? Doit retourner {"status":"UP"}
echo.
echo ?? SI UN SERVICE ?CHOUE :
echo - V?rifiez la fen?tre du service correspondant
echo - Cherchez "Started ...Application" dans les logs
echo - V?rifiez qu'aucune erreur de port n'appara?t
echo.
pause
