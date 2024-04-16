CREATE TABLE IF NOT EXISTS contact_requests (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    sender INTEGER NOT NULL,
    receiver INTEGER NOT NULL,
    accepted BOOLEAN,
    CONSTRAINT fk_sender FOREIGN KEY (sender) REFERENCES users (id),
    CONSTRAINT fk_receiver FOREIGN KEY (receiver) REFERENCES users (id)
);
