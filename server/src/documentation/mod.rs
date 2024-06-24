use utoipa::{openapi::ServerBuilder, OpenApi};

use self::paths::{PathId, PathUsername};
use crate::accounts::{__path_get_user_by_uid, __path_get_user_by_username, __path_me};
use crate::db::models::user::{NewUser, User};
use crate::error::DouchatError;
use crate::oauth::{
    apple::{AppleName, AppleOauthPayload, AppleUser, __path_apple_auth},
    google::{GoogleOAuthPayload, __path_google_auth},
};
use crate::security::jwt::__path_refresh_access_token;

use crate::env::API_BASE_URL;

pub mod paths;

#[derive(OpenApi)]
#[openapi(
    info(
        title = "Douchat API"
    ),
    tags(
        (name = "OAuth", description = "OAuth focused authentication"),
        (name = "Login", description = "Traditional ways to authenticate"),
        (name = "Accounts", description = "Accounts"),
    ),
    components(
        schemas(
            User,
            NewUser,
            AppleOauthPayload,
            AppleUser,
            AppleName,
            GoogleOAuthPayload,
            PathId,
            PathUsername,
            DouchatError
        )
    ),
    paths(
        // OAuth
        apple_auth,
        google_auth,
        // Login
        refresh_access_token,
        // Accounts
        get_user_by_uid,
        get_user_by_username,
        me,
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
