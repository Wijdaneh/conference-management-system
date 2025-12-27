CREATE DATABASE conference_db;
CREATE USER conference_user WITH ENCRYPTED PASSWORD 'conference_pass';
GRANT ALL PRIVILEGES ON DATABASE conference_db TO conference_user;

\c conference_db;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO conference_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO conference_user;