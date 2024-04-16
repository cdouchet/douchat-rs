use crate::{env::APPLE_CLIENT_ID, security::jwt::access_and_refresh, utils::response_with_token};
use actix_web::{
    post,
    web::{Data, Form},
    HttpResponse,
};
use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
use serde::{Deserialize, Serialize};

use crate::{
    db::models::user::NewUser,
    error::{DouchatError, Result},
    http::HTTP_CLIENT,
    state::DouchatState,
};

#[derive(Debug, Deserialize)]
pub struct AppleOauthPayload {
    pub code: String,
    pub state: Option<String>,
    pub id_token: String,
    pub user: Option<String>,
}

#[allow(unused)]
#[derive(Deserialize)]
struct AppleKey {
    kty: String,
    kid: String,
    r#use: String,
    alg: String,
    pub n: String,
    pub e: String,
}

#[derive(Deserialize)]
struct AppleKeys {
    keys: Vec<AppleKey>,
}

#[derive(Deserialize)]
pub struct AppleTokenPayload {
    pub access_token: String,
    pub token_type: String,
    pub expires_in: u64,
    pub refresh_token: String,
    pub id_token: String,
}

#[derive(Debug, Clone, Deserialize)]
#[allow(non_snake_case)]
pub struct AppleName {
    pub firstName: String,
    pub lastName: String,
}

impl AppleName {
    pub fn join(&self) -> String {
        format!("{} {}", &self.firstName, &self.lastName)
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct AppleUser {
    pub name: AppleName,
    pub email: String,
}

#[derive(Deserialize, Serialize)]
pub struct AppleIdTokenClaims {
    iss: String,
    aud: String,
    exp: u64,
    iat: u64,
    sub: String,
    c_hash: Option<String>,
    pub email: String,
    email_verified: bool,
    is_private_email: Option<bool>,
    auth_time: u64,
    nonce_supported: bool,
}

#[derive(Deserialize)]
pub struct AppleIdTokenHeader {
    pub kid: String,
    _alg: String,
}

impl AppleOauthPayload {
    pub async fn get_claims(&self) -> Result<AppleIdTokenClaims> {
        let client = &HTTP_CLIENT;
        let apple_keys = client
            .get("https://appleid.apple.com/auth/keys")
            .header("Accept-Encoding", "gzip, deflate, br")
            .send()
            .await
            .unwrap()
            .json::<AppleKeys>()
            .await
            .unwrap();
        let apple_header = jsonwebtoken::decode_header(&self.id_token)
            .expect("Unexpected error: Apple JWT Header could not be decoded");
        let apple_kid = apple_header.kid.unwrap();
        let apple_key = apple_keys
            .keys
            .iter()
            .find(|&x| x.kid == apple_kid)
            .unwrap();
        let decoding_key = DecodingKey::from_rsa_components(&apple_key.n, &apple_key.e)
            .expect("Could not find a suitable apple key to decode the id_token");
        let mut validation = Validation::new(Algorithm::RS256);
        validation.set_audience(&[&APPLE_CLIENT_ID.to_string()]);
        let decoded = decode::<AppleIdTokenClaims>(&self.id_token, &decoding_key, &validation);
        if let Err(err) = decoded {
            println!("Err decoding apple user. Err: {err}");
            return Err(DouchatError::internal_server_error());
        }
        Ok(decoded.unwrap().claims)
    }
}

#[post("/login/apple")]
pub async fn apple_auth(
    state: Data<DouchatState>,
    Form(payload): Form<AppleOauthPayload>,
) -> Result<HttpResponse> {
    let claims = payload.get_claims().await?;
    match state.db().email_exists(&claims.email)? {
        Some(user) => {
            let claims = access_and_refresh(user.uid, user.id);
            return Ok(response_with_token(user, claims)?);
        }
        None => {
            let new_user = NewUser::from((payload, claims));
            let user = state.db().create_user(new_user)?;
            let claims = access_and_refresh(user.uid, user.id);
            return Ok(response_with_token(user, claims)?);
        }
    }
}
