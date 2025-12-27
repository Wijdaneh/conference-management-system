@echo off
echo ========================================
echo   LIB?RATION DES PORTS DES SERVICES
echo ========================================
echo.

echo Ports ? lib?rer : 8761, 8888, 8080, 8081, 8082
echo.

set PORTS=8761 8888 8080 8081 8082

for %%p in (%PORTS%) do (
    echo.
    echo [Port %%p] Recherche du processus...
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%%p ^| findstr LISTENING') do (
        if not "%%a"=="0" (
            echo   Processus trouv?: PID=%%a
            taskkill /PID %%a /F >nul 2>&1
            if errorlevel 0 (
                echo   ? Processus %%a termin?
            ) else (
                echo   ? Impossible de terminer le processus %%a
            )
        ) else (
            echo   ? Port %%p libre
        )
    )
)

echo.
echo ========================================
echo   PORTS LIB?R?S
echo ========================================
echo.
echo Vous pouvez maintenant red?marrer les services.
echo.
pause
