CREATE TABLE IF NOT EXISTS user_pictures (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    id BIGSERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (id),
    image_data BYTEA NOT NULL
);