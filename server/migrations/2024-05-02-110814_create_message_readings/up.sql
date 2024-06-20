CREATE TABLE IF NOT EXISTS message_readings(
    id BIGSERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    message_id BIGINT NOT NULL,
    reader INTEGER NOT NULL,
    CONSTRAINT fk_message_id FOREIGN KEY (message_id) REFERENCES messages (id),
    CONSTRAINT fk_reader FOREIGN KEY (reader) REFERENCES users (id)
);
