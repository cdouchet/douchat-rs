CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    uid uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    username VARCHAR NOT NULL UNIQUE,
    photo_url VARCHAR,
    verification_date TIMESTAMP WITH TIME ZONE,
    description VARCHAR,
    status VARCHAR
)
