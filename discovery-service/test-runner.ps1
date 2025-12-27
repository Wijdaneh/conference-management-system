function Invoke-IntelligentTests {
    param(
        [ValidateSet("fast", "full", "ci")]
        [string]$Mode = "fast"
    )
    
    Write-Host "🧠 TESTS INTELLIGENTS - Mode: $Mode" -ForegroundColor Cyan
    Write-Host "===================================" -ForegroundColor Cyan
    
    # Nettoyer
    mvn clean -q
    Write-Host "✅ Nettoyage terminé" -ForegroundColor Green
    
    # Compiler
    mvn compile -DskipTests -q
    Write-Host "✅ Compilation terminée" -ForegroundColor Green
    
    # Exécuter les tests selon le mode
    switch ($Mode) {
        "fast" {
            Write-Host "`n⚡ Mode RAPIDE - Tests unitaires seulement" -ForegroundColor Yellow
            mvn test --% -Dtest="**/unit/*Test.java" -Dskip.integration.tests=true
        }
        "full" {
            Write-Host "`n🔍 Mode COMPLET - Tous les tests (sauf Eureka)" -ForegroundColor Yellow
            mvn test --% -Dskip.eureka.tests=true -Dmaven.test.failure.ignore=false
        }
        "ci" {
            Write-Host "`n🏗️  Mode CI/CD - Tests avec rapports" -ForegroundColor Yellow
            mvn test --% -Dskip.eureka.tests=true -Dmaven.test.failure.ignore=false jacoco:report
            
            # Vérifier la couverture
            if (Test-Path "target/site/jacoco/index.html") {
                $coverage = Get-Content "target/site/jacoco/index.html" | Select-String -Pattern "Total.*?([\d\.]+)%" | % { $_.Matches.Groups[1].Value }
                Write-Host "📊 Couverture de code: $coverage%" -ForegroundColor Blue
                
                if ([float]$coverage -lt 80) {
                    Write-Host "⚠️  Attention: Couverture inférieure à 80%" -ForegroundColor Yellow
                }
            }
        }
    }
    
    # Résultat final
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n🎉 SUCCÈS : Tous les tests passent !" -ForegroundColor Green
        return $true
    } else {
        Write-Host "`n❌ ÉCHEC : Certains tests ont échoué" -ForegroundColor Red
        
        # Afficher les rapports
        if (Test-Path "target/surefire-reports") {
            $failedReports = Get-ChildItem "target/surefire-reports/*.txt" | Where-Object { $_ -match "fail" }
            if ($failedReports.Count -gt 0) {
                Write-Host "📋 Rapports d'échec disponibles :" -ForegroundColor Gray
                $failedReports | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Gray }
            }
        }
        
        return $false
    }
}

# Exporter la fonction pour pouvoir l'utiliser
Export-ModuleMember -Function Invoke-IntelligentTests
