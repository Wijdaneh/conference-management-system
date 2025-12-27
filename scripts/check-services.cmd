@echo off
echo ========================================
echo   V?RIFICATION RAPIDE DES SERVICES
echo ========================================
echo.

echo [1/4] V?rification des ports...
echo Port 8761 (Discovery): 
netstat -ano | findstr :8761 >nul && echo ? OCCUP? || echo ? LIBRE
echo Port 8888 (Config): 
netstat -ano | findstr :8888 >nul && echo ? OCCUP? || echo ? LIBRE
echo Port 8082 (Conference): 
netstat -ano | findstr :8082 >nul && echo ? OCCUP? || echo ? LIBRE
echo Port 8081 (Keynote): 
netstat -ano | findstr :8081 >nul && echo ? OCCUP? || echo ? LIBRE
echo Port 8080 (Gateway): 
netstat -ano | findstr :8080 >nul && echo ? OCCUP? || echo ? LIBRE

echo.
echo [2/4] V?rification des processus Java...
tasklist | findstr java >nul && echo ??  Processus Java d?tect?s || echo ? Aucun processus Java

echo.
echo [3/4] V?rification des fichiers de configuration...
if exist conference-service\src\main\resources\application.yml (
    echo ? Conference: application.yml pr?sent
) else (
    echo ? Conference: application.yml manquant
)

if exist keynote-service\src\main\resources\application.yml (
    echo ? Keynote: application.yml pr?sent
) else (
    echo ? Keynote: application.yml manquant
)

echo.
echo [4/4] Test de compilation rapide...
cd conference-service
mvn clean compile -q >nul 2>&1
if errorlevel 1 (
    echo ? Conference Service: Erreur de compilation
) else (
    echo ? Conference Service: Compilation OK
)

cd ..\keynote-service
mvn clean compile -q >nul 2>&1
if errorlevel 1 (
    echo ? Keynote Service: Erreur de compilation
) else (
    echo ? Keynote Service: Compilation OK
)

cd ..
echo.
echo ========================================
echo   V?RIFICATION TERMIN?E
echo ========================================
echo.
pause
