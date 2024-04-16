CREATE TABLE IF NOT EXISTS messages (
    id BIGSERIAL PRIMARY KEY,
    uid uuid NOT NULL DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    sender INTEGER NOT NULL,
    room INTEGER NOT NULL,
    content TEXT NOT NULL,
    message_type VARCHAR NOT NULL,
    CONSTRAINT fk_sender FOREIGN KEY (sender) REFERENCES users (id),
    CONSTRAINT fk_room FOREIGN KEY (room) REFERENCES rooms (id)
);
