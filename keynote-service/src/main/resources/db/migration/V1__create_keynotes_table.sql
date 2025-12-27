CREATE TABLE keynotes (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    speaker VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    conference_id BIGINT,
    max_attendees INTEGER,
    current_attendees INTEGER DEFAULT 0,
    is_published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_keynotes_published ON keynotes(is_published);
CREATE INDEX idx_keynotes_conference ON keynotes(conference_id);
CREATE INDEX idx_keynotes_speaker ON keynotes(speaker);
CREATE INDEX idx_keynotes_dates ON keynotes(start_time, end_time);
