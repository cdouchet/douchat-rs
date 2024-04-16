CREATE TABLE IF NOT EXISTS contacts (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    user_id INTEGER REFERENCES users (id),
    contact_id INTEGER REFERENCES users (id),
    request_id INTEGER NOT NULL,
    CONSTRAINT fk_request_id FOREIGN KEY (request_id) REFERENCES contact_requests (id),
    PRIMARY KEY (user_id, contact_id)
);
