use lazy_static::lazy_static;
use std::env::var;

lazy_static! {
    pub static ref API_PORT: u16 = var("API_PORT")
        .expect("API_PORT must be set")
        .parse::<u16>()
        .expect("API_PORT must be an unsigned integer");
    pub static ref DATABASE_URL: String = var("DATABASE_URL").expect("DATABASE_URL must be set");
    pub static ref APPLE_CLIENT_ID: String =
        var("APPLE_CLIENT_ID").expect("APPLE_CLIENT_ID must be set");
    pub static ref JWT_SECRET: String = var("JWT_SECRET").expect("JWT_SECRET must be set");
    pub static ref JWT_ISSUER: String = var("JWT_ISSUER").expect("JWT_ISSUER must be set");
}
