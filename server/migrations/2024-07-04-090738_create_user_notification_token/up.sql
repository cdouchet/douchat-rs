CREATE TABLE IF NOT EXISTS user_notification_token (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    id BIGSERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users (id),
    device_id BIGINT NOT NULL REFERENCES user_devices (id),
    token TEXT NOT NULL
);
