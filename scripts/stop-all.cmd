@echo off
echo ========================================
echo   ARR?T CONFERENCE MANAGEMENT
echo ========================================
echo.

echo Cette commande fermera toutes les fen?tres de services.
echo.

echo [1/4] Fermer Gateway Service...
taskkill /FI "WINDOWTITLE eq Gateway Service" /F 2>nul

echo [2/4] Fermer Keynote Service...
taskkill /FI "WINDOWTITLE eq Keynote Service" /F 2>nul

echo [3/4] Fermer Conference Service...
taskkill /FI "WINDOWTITLE eq Conference Service" /F 2>nul

echo [4/4] Fermer Config et Discovery Services...
taskkill /FI "WINDOWTITLE eq Config Service" /F 2>nul
taskkill /FI "WINDOWTITLE eq Discovery Service" /F 2>nul

echo.
echo ? Tous les services ont ?t? arr?t?s
echo.
echo Pour red?marrer : start-all-h2.cmd
echo.
pause
