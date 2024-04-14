use actix_web::web::{Data, Query};
use actix_web::{get, HttpResponse};
use serde::{Deserialize, Serialize};

use crate::db::models::user::NewUser;
use crate::env::{GOOGLE_REDIRECT_URI, GOOGLE_SECRET};

use crate::error::{DouchatError, Result};
use crate::http::HTTP_CLIENT;
use crate::security::jwt::access_and_refresh;
use crate::state::DouchatState;
use crate::utils::response_with_token;

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
pub struct GoogleSecretInfos {
    client_id: String,
    project_id: String,
    auth_uri: String,
    token_uri: String,
    auth_provider_x509_cert_url: String,
    client_secret: String,
    redirect_uris: Vec<String>,
    javascript_origins: Vec<String>,
}

#[derive(Debug, Deserialize)]
pub struct GoogleSecret {
    web: GoogleSecretInfos,
}

impl GoogleSecret {
    pub fn load() -> Self {
        let cargo_manifest_dir =
            std::env::var("CARGO_MANIFEST_DIR").expect("Could not find CARGO_MANIFEST_DIR env var");
        let google_secret_path = format!("{}/google_secret.json", cargo_manifest_dir);
        let google_secret_file_contents =
            std::fs::read_to_string(google_secret_path).expect("Could not find google_secret.json");
        serde_json::from_str(&google_secret_file_contents)
            .expect("Error reading google_secret.json. It may have an invalid format")
    }
}

#[derive(Deserialize, Clone, Debug)]
#[allow(dead_code)]
struct GoogleOAuthPayload {
    code: String,
    scope: String,
    authuser: String,
    state: String,
}

#[derive(Debug, Serialize)]
struct GooglePostPayload {
    code: String,
    client_id: String,
    client_secret: String,
    redirect_uri: String,
    grant_type: String,
}

impl GooglePostPayload {
    fn from_code(code: String) -> Self {
        Self {
            code,
            client_id: GOOGLE_SECRET.web.client_id.clone(),
            client_secret: GOOGLE_SECRET.web.client_secret.clone(),
            grant_type: String::from("authorization_code"),
            redirect_uri: GOOGLE_REDIRECT_URI.to_string(),
        }
    }

    async fn get_token_payload(self) -> Result<GoogleTokenPayload> {
        let client = &HTTP_CLIENT;
        client
            .post("https://oauth2.googleapis.com/token")
            .body(serde_json::to_string(&self).unwrap())
            .header("Content-Type", "application/json")
            .header("Accept", "*/*")
            .header("Accept-Encoding", "gzip, deflate, br")
            .header("Connection", "keep-alive")
            .send()
            .await
            .map_err(|_| DouchatError::internal_server_error())?
            .json::<GoogleTokenPayload>()
            .await
            .map_err(|_| DouchatError::internal_server_error())
    }
}

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
struct GoogleTokenPayload {
    access_token: String,
    expires_in: u32,
    scope: String,
    token_type: String,
    id_token: String,
}

impl GoogleTokenPayload {
    async fn get_identity_response(&self) -> Result<GoogleIdentityResponse> {
        let client = &HTTP_CLIENT;
        client
            .get(format!(
                "https://www.googleapis.com/oauth2/v1/userinfo?access_token={}",
                self.access_token
            ))
            .send()
            .await
            .map_err(|_| DouchatError::internal_server_error())?
            .json::<GoogleIdentityResponse>()
            .await
            .map_err(|_| DouchatError::internal_server_error())
    }
}

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
struct GoogleJWTHeader {
    alg: String,
    kid: String,
    typ: String,
}

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
struct GoogleJWTClaims {
    iss: String,
    azp: String,
    aud: String,
    sub: String,
    email: String,
    at_hash: String,
    name: String,
    picture: String,
    given_name: String,
    family_name: String,
    locale: String,
    iat: String,
    exp: String,
}

#[derive(Debug, Deserialize, Clone)]
pub struct GoogleIdentityResponse {
    pub id: String,
    pub email: String,
    pub verified_email: bool,
    pub name: String,
    pub given_name: String,
    pub family_name: String,
    pub picture: String,
    pub locale: String,
}

#[derive(Debug, Deserialize)]
#[allow(dead_code)]
struct GoogleTokenResponse {
    error: String,
    error_description: String,
}

#[get("/login/google")]
pub async fn google_auth(
    params: Query<GoogleOAuthPayload>,
    state: Data<DouchatState>,
) -> Result<HttpResponse> {
    let post_payload = GooglePostPayload::from_code(params.code.clone());
    let token_payload = post_payload.get_token_payload().await?;
    let identity = token_payload.get_identity_response().await?;
    let user = state.db().email_exists(&identity.email)?;
    match user {
        Some(user) => {
            let uid = user.uid;
            let claims = access_and_refresh(uid);
            return Ok(response_with_token(user, claims)?);
        }
        None => {
            let mut new_user = NewUser::from(identity.clone());
            if state.db().get_user_by_username(&identity.name)?.is_some() {
                new_user.username = None;
                new_user.verification_date = None;
            }
            let user = state.db().create_user(new_user)?;
            let claims = access_and_refresh(user.uid);
            return Ok(response_with_token(user, claims)?);
        }
    }
}
