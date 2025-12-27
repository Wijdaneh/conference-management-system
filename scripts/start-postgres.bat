@echo off
echo ========================================
echo   D?MARRAGE DE POSTGRESQL
echo ========================================
echo.

echo [1/3] V?rification de PostgreSQL...
where psql >nul 2>&1
if errorlevel 1 (
    echo ? PostgreSQL n'est pas install? ou n'est pas dans le PATH
    echo T?l?chargez-le depuis: https://www.postgresql.org/download/windows/
    pause
    exit /b 1
)

echo ? PostgreSQL est disponible
echo.

echo [2/3] V?rification du service PostgreSQL...
net start | findstr /i "postgresql" >nul
if errorlevel 1 (
    echo ??  Le service PostgreSQL n'est pas d?marr?
    echo Tentative de d?marrage...
    net start postgresql-x64-15 >nul 2>&1 || net start postgresql-15 >nul 2>&1 || net start postgresql >nul 2>&1
    if errorlevel 1 (
        echo ? Impossible de d?marrer PostgreSQL automatiquement
        echo D?marrez-le manuellement via:
        echo - Services Windows (services.msc)
        echo - pgAdmin
        echo - Dossier d'installation de PostgreSQL
    ) else (
        echo ? PostgreSQL d?marr? avec succ?s
    )
) else (
    echo ? PostgreSQL est d?j? d?marr?
)

echo.
echo [3/3] V?rification de la connexion...
psql -U postgres -c "SELECT version();" >nul 2>&1
if errorlevel 1 (
    echo ? Impossible de se connecter ? PostgreSQL
    echo V?rifiez:
    echo 1. Le service est d?marr?
    echo 2. Le mot de passe par d?faut est 'postgres'
    echo 3. Le port 5432 est accessible
) else (
    echo ? Connexion PostgreSQL r?ussie
    echo.
    echo ?? Informations de base de donn?es:
    echo - H?te: localhost
    echo - Port: 5432
    echo - Utilisateur: conference_user
    echo - Mot de passe: conference_pass
    echo - Base: conference_db
)

echo.
echo ========================================
echo   CONFIGURATION TERMIN?E
echo ========================================
echo.
echo Pour initialiser la base de donn?es:
echo psql -U postgres -f init-database.sql
echo.
pause
