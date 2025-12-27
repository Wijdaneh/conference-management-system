@echo off
echo ========================================
echo   D?MARRAGE CONFERENCE MANAGEMENT
echo ========================================
echo.

echo [1/5] D?marrer Discovery Service...
start "Discovery" run-discovery.cmd
timeout /t 5 >nul

echo [2/5] D?marrer Config Service...
start "Config" run-config.cmd
timeout /t 5 >nul

echo [3/5] D?marrer Conference Service...
start "Conference" run-conference.cmd
timeout /t 5 >nul

echo [4/5] D?marrer Keynote Service...
start "Keynote" run-keynote.cmd
timeout /t 5 >nul

echo [5/5] D?marrer Gateway Service...
start "Gateway" run-gateway.cmd

echo.
echo ? Tous les services sont en cours de d?marrage
echo.
echo ?? URLs :
echo - Eureka: http://localhost:8761
echo - Gateway: http://localhost:8080
echo.
echo ? Attendez 1-2 minutes que tous les services d?marrent
echo.
pause
