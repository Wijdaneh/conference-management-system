-- Script de données de test pour Keynote
DELETE FROM KEYNOTE;

INSERT INTO KEYNOTE (title, speaker, duration, conference_id, start_time, end_time) VALUES
('The Future of AI in Development', 'Dr. Sarah Chen', 45, 1, '2024-06-15 09:00:00', '2024-06-15 09:45:00'),
('Cloud Native Applications', 'Michael Rodriguez', 60, 1, '2024-06-15 10:00:00', '2024-06-15 11:00:00'),
('DevSecOps Best Practices', 'Lisa Thompson', 90, 1, '2024-06-15 11:30:00', '2024-06-15 13:00:00'),
('React 18 New Features', 'David Park', 45, 2, '2024-06-16 14:00:00', '2024-06-16 14:45:00'),
('Database Performance Tuning', 'Robert Kim', 75, 2, '2024-06-16 15:00:00', '2024-06-16 16:15:00'),
('Microservices Communication Patterns', 'Emma Wilson', 60, 3, '2024-06-17 09:30:00', '2024-06-17 10:30:00');

SELECT 'Données insérées: ' || COUNT(*) || ' keynotes' as result FROM KEYNOTE;
