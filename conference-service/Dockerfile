# Utiliser une image Java 17 officielle
FROM openjdk:17-jdk-slim

# Créer un répertoire pour l'application
WORKDIR /app

# Copier le JAR
COPY target/conference-service-1.0.0.jar app.jar

# Exposer le port spécifique au service
EXPOSE 8082

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]
