use utoipa::{openapi::ServerBuilder, OpenApi};

use crate::db::models::user::User;
use crate::error::DouchatError;
use crate::oauth::{
    apple::{AppleName, AppleOauthPayload, AppleUser, __path_apple_auth},
    google::{GoogleOAuthPayload, __path_google_auth},
};
use crate::security::jwt::__path_refresh_access_token;

use crate::env::API_BASE_URL;

#[derive(OpenApi)]
#[openapi(
    info(
        title = "Douchat API"
    ),
    tags(
        (name = "OAuth", description = "OAuth focused authentication"),
        (name = "Login", description = "Traditional ways to authenticate"),
    ),
    components(
        schemas(
            User,
            AppleOauthPayload,
            AppleUser,
            AppleName,
            GoogleOAuthPayload,
            DouchatError
        )
    ),
    paths(
        apple_auth,
        google_auth,
        refresh_access_token,
    )
)]
pub struct ApiDoc;

impl ApiDoc {
    pub fn create() -> utoipa::openapi::OpenApi {
        let mut doc = Self::openapi();
        let server = ServerBuilder::new().url(API_BASE_URL.to_string()).build();
        doc.servers = Some(vec![server]);
        doc
    }
}
