CREATE TABLE conferences (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    max_attendees INTEGER NOT NULL,
    current_attendees INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conference_speakers (
    conference_id BIGINT NOT NULL,
    speaker VARCHAR(255) NOT NULL,
    PRIMARY KEY (conference_id, speaker),
    FOREIGN KEY (conference_id) REFERENCES conferences(id) ON DELETE CASCADE
);

CREATE INDEX idx_conferences_active ON conferences(is_active);
CREATE INDEX idx_conferences_dates ON conferences(start_date, end_date);