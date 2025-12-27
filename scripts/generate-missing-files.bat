@echo off
echo ========================================
echo   G?N?RATEUR DE FICHIERS MANQUANTS
echo ========================================
echo.

REM Demander le service cible
echo Services disponibles:
echo 1. discovery-service
echo 2. config-service
echo 3. gateway-service
echo 4. conference-service
echo 5. keynote-service
echo.
set /p serviceChoice="Choisir le service [1-5]: "

if "%serviceChoice%"=="1" set SERVICE=discovery-service && set PORT=8761
if "%serviceChoice%"=="2" set SERVICE=config-service && set PORT=8888
if "%serviceChoice%"=="3" set SERVICE=gateway-service && set PORT=8080
if "%serviceChoice%"=="4" set SERVICE=conference-service && set PORT=8081
if "%serviceChoice%"=="5" set SERVICE=keynote-service && set PORT=8082

echo.
echo Service s?lectionn?: %SERVICE% (port: %PORT%)
echo.

REM V?rifier la structure
echo [1/5] V?rification de la structure...
if not exist "%SERVICE%\src\main\java\com\conference" (
    echo ? Package Java manquant
    echo ? Cr?ation...
    mkdir "%SERVICE%\src\main\java\com\conference"
) else (
    echo ? Package Java existant
)

if not exist "%SERVICE%\src\main\resources" (
    echo ? Dossier resources manquant
    echo ? Cr?ation...
    mkdir "%SERVICE%\src\main\resources"
) else (
    echo ? Dossier resources existant
)

REM Cr?er application.yml si manquant
echo.
echo [2/5] V?rification application.yml...
if not exist "%SERVICE%\src\main\resources\application.yml" (
    echo ? application.yml manquant
    echo ? Cr?ation...
    
    echo server: > "%SERVICE%\src\main\resources\application.yml"
    echo   port: %PORT% >> "%SERVICE%\src\main\resources\application.yml"
    echo. >> "%SERVICE%\src\main\resources\application.yml"
    echo spring: >> "%SERVICE%\src\main\resources\application.yml"
    echo   application: >> "%SERVICE%\src\main\resources\application.yml"
    echo     name: %SERVICE% >> "%SERVICE%\src\main\resources\application.yml"
    
    if "%SERVICE%"=="discovery-service" (
        echo. >> "%SERVICE%\src\main\resources\application.yml"
        echo eureka: >> "%SERVICE%\src\main\resources\application.yml"
        echo   client: >> "%SERVICE%\src\main\resources\application.yml"
        echo     register-with-eureka: false >> "%SERVICE%\src\main\resources\application.yml"
        echo     fetch-registry: false >> "%SERVICE%\src\main\resources\application.yml"
    ) else (
        echo. >> "%SERVICE%\src\main\resources\application.yml"
        echo eureka: >> "%SERVICE%\src\main\resources\application.yml"
        echo   client: >> "%SERVICE%\src\main\resources\application.yml"
        echo     service-url: >> "%SERVICE%\src\main\resources\application.yml"
        echo       defaultZone: http://localhost:8761/eureka/ >> "%SERVICE%\src\main\resources\application.yml"
    )
    
    echo. >> "%SERVICE%\src\main\resources\application.yml"
    echo management: >> "%SERVICE%\src\main\resources\application.yml"
    echo   endpoints: >> "%SERVICE%\src\main\resources\application.yml"
    echo     web: >> "%SERVICE%\src\main\resources\application.yml"
    echo       exposure: >> "%SERVICE%\src\main\resources\application.yml"
    echo         include: health,info,metrics >> "%SERVICE%\src\main\resources\application.yml"
    
    echo ? application.yml cr??
) else (
    echo ? application.yml existant
)

REM Cr?er la classe Application si manquante
echo.
echo [3/5] V?rification classe Application...
set PACKAGE_PATH=%SERVICE:-=%
if "%SERVICE%"=="discovery-service" set MAIN_CLASS=DiscoveryServiceApplication
if "%SERVICE%"=="config-service" set MAIN_CLASS=ConfigServiceApplication
if "%SERVICE%"=="gateway-service" set MAIN_CLASS=GatewayServiceApplication
if "%SERVICE%"=="conference-service" set MAIN_CLASS=ConferenceServiceApplication
if "%SERVICE%"=="keynote-service" set MAIN_CLASS=KeynoteServiceApplication

if not exist "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java" (
    echo ? Classe principale manquante
    echo ? Cr?ation...
    
    mkdir "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%" 2>nul
    
    echo package com.conference.%PACKAGE_PATH%; > "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo import org.springframework.boot.SpringApplication; >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo import org.springframework.boot.autoconfigure.SpringBootApplication; >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo @SpringBootApplication >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo public class %MAIN_CLASS% { >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo     public static void main(String[] args) { >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo         SpringApplication.run(%MAIN_CLASS%.class, args); >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo     } >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    echo } >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\%MAIN_CLASS%.java"
    
    echo ? %MAIN_CLASS%.java cr??e
) else (
    echo ? Classe principale existante
)

REM Cr?er une structure de contr?leur exemple
echo.
echo [4/5] V?rification structure MVC...
if not exist "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller" (
    echo ??  Dossier controller manquant
    set /p createController="Cr?er un contr?leur exemple? (o/n): "
    if /i "%createController%"=="o" (
        mkdir "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller"
        
        echo package com.conference.%PACKAGE_PATH%.controller; > "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo import org.springframework.web.bind.annotation.*; >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo @RestController >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo @RequestMapping("/api/example") >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo public class ExampleController { >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo. >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo     @GetMapping >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo     public String hello() { >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo         return "Hello from %SERVICE%!"; >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo     } >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        echo } >> "%SERVICE%\src\main\java\com\conference\%PACKAGE_PATH%\controller\ExampleController.java"
        
        echo ? ExampleController.java cr??
    )
) else (
    echo ? Dossier controller existant
)

REM Cr?er dossier de tests
echo.
echo [5/5] V?rification tests...
if not exist "%SERVICE%\src\test\java" (
    echo ??  Dossier de tests manquant
    set /p createTests="Cr?er la structure de tests? (o/n): "
    if /i "%createTests%"=="o" (
        mkdir "%SERVICE%\src\test\java\com\conference\%PACKAGE_PATH%"
        mkdir "%SERVICE%\src\test\resources" 2>nul
        echo ? Structure de tests cr??e
    )
) else (
    echo ? Dossier de tests existant
)

echo.
echo ========================================
echo   G?N?RATION TERMIN?E
echo ========================================
echo.
echo R?sum? pour %SERVICE%:
echo - Package Java: com.conference.%PACKAGE_PATH%
echo - Port: %PORT%
echo - Classe principale: %MAIN_CLASS%
echo - Configuration: application.yml
echo.
echo Pour tester: cd %SERVICE% && mvn spring-boot:run
echo.
pause
