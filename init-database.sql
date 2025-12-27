-- Base de données pour Conference Management
CREATE DATABASE conference_db;

-- Connexion à la base
\c conference_db;

-- Utilisateur
CREATE USER conference_user WITH PASSWORD 'conference_pass';

-- Privilèges
GRANT ALL PRIVILEGES ON DATABASE conference_db TO conference_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO conference_user;

-- Table conferences (si elle n'existe pas)
CREATE TABLE IF NOT EXISTS conferences (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table keynotes (si elle n'existe pas)
CREATE TABLE IF NOT EXISTS keynotes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    speaker VARCHAR(255),
    duration INTEGER,
    conference_id INTEGER REFERENCES conferences(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Données de test
INSERT INTO conferences (title, description, location, start_date, end_date) VALUES
('Conférence Spring Boot', 'Conférence sur Spring Boot et microservices', 'Paris', '2024-06-01 09:00:00', '2024-06-01 17:00:00'),
('Event Docker', 'Workshop sur Docker et Kubernetes', 'Lyon', '2024-07-15 10:00:00', '2024-07-15 18:00:00')
ON CONFLICT DO NOTHING;

INSERT INTO keynotes (title, speaker, duration, conference_id) VALUES
('Introduction à Spring Boot', 'John Doe', 60, 1),
('Docker pour les développeurs', 'Jane Smith', 90, 2)
ON CONFLICT DO NOTHING;

-- Vérification
SELECT 'Base de données initialisée avec succès' as status;
