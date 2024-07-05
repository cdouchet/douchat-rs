CREATE TABLE IF NOT EXISTS user_devices (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    id BIGSERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (id),
    device_id TEXT NOT NULL UNIQUE,
    device_name TEXT NOT NULL
);
