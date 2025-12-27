Write-Host "Démarrage du projet conference-management..." -ForegroundColor Green
docker-compose down
docker-compose up -d --build
Write-Host "Services démarrés !" -ForegroundColor Green