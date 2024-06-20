use std::time::{Duration, SystemTime, UNIX_EPOCH};

use crate::{
    db::models::user::NewUser,
    env::{JWT_ISSUER, JWT_SECRET},
    state::DouchatState,
    utils::response_with_token,
};
use actix_web::{
    cookie::{time::OffsetDateTime, Cookie, CookieBuilder},
    get,
    http::{header::ContentType, StatusCode},
    web::Data,
    FromRequest, HttpResponse, HttpResponseBuilder,
};
use jsonwebtoken::{decode, encode, DecodingKey, EncodingKey, Validation};
use serde::{de::DeserializeOwned, Deserialize, Serialize};
use uuid::Uuid;

use crate::error::{error_from_jwt::from_jwt_error, DouchatError};

/// Helper trait to differentiate between access_token and refresh_token
pub trait DouchatTokenType: std::fmt::Debug + Sized + Serialize {
    /// Name of the cookie
    fn cookie_name<'b>() -> &'b str;
    /// Time of the cookie validity
    fn validity() -> u64;
}
#[derive(Debug, Deserialize, Serialize)]
pub struct Access;
impl DouchatTokenType for Access {
    fn cookie_name<'b>() -> &'b str {
        "t"
    }
    fn validity() -> u64 {
        // 1 week
        60 * 60 * 24 * 7
    }
}
#[derive(Debug, Serialize, Deserialize)]
pub struct Refresh;
impl DouchatTokenType for Refresh {
    fn cookie_name<'b>() -> &'b str {
        "rf"
    }
    fn validity() -> u64 {
        // 1 month
        60 * 60 * 24 * 30
    }
}

// #[derive(Debug, Serialize, Deserialize)]
// pub enum DouchatTokenType {
//     Access,
//     Refresh,
// }

#[derive(Debug, Serialize, Deserialize)]
pub struct DouchatJWTClaims<T: DouchatTokenType> {
    iat: u64,
    exp: u64,
    iss: String,
    pub uid: Uuid,
    pub id: i32,
    pub r#type: T,
}

impl<'a, T: DouchatTokenType + Deserialize<'static>> DouchatJWTClaims<T> {
    pub fn new(uid: Uuid, id: i32, r#type: T) -> Self {
        let now_timer = SystemTime::now();
        let timer = now_timer + Duration::from_secs(605800);
        Self {
            exp: timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            iat: now_timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            uid,
            id,
            iss: JWT_ISSUER.to_string(),
            r#type,
        }
    }

    pub fn to_token(self) -> crate::error::Result<String> {
        let header = jsonwebtoken::Header::default();
        let key = EncodingKey::from_secret(JWT_SECRET.as_bytes());
        encode(&header, &self, &key).map_err(from_jwt_error)
    }
}

pub fn access_and_refresh(
    uid: Uuid,
    id: i32,
) -> (DouchatJWTClaims<Access>, DouchatJWTClaims<Refresh>) {
    (
        DouchatJWTClaims::new(uid, id, Access),
        DouchatJWTClaims::new(uid, id, Refresh),
    )
}

impl<T: DouchatTokenType + DeserializeOwned + 'static> TryFrom<Cookie<'static>>
    for DouchatJWTClaims<T>
{
    type Error = DouchatError;

    fn try_from(value: Cookie<'static>) -> Result<Self, Self::Error> {
        let decoding_key = DecodingKey::from_secret(JWT_SECRET.as_bytes());
        let validation = Validation::default();
        decode::<Self>(value.value(), &decoding_key, &validation)
            .map(|e| e.claims)
            .map_err(from_jwt_error)
    }
}

impl<T: DouchatTokenType + Deserialize<'static>> TryInto<Cookie<'static>> for DouchatJWTClaims<T> {
    type Error = DouchatError;

    fn try_into(self) -> crate::error::Result<Cookie<'static>> {
        let expires = OffsetDateTime::now_utc() + Duration::from_secs(T::validity());
        Ok(CookieBuilder::new(T::cookie_name(), self.to_token()?)
            .path("/")
            .secure(true)
            .http_only(true)
            .expires(expires)
            .finish())
    }
}

impl<T: DouchatTokenType + DeserializeOwned + 'static> FromRequest for DouchatJWTClaims<T> {
    type Error = DouchatError;
    type Future = futures::future::Ready<Result<Self, Self::Error>>;

    fn from_request(req: &actix_web::HttpRequest, _: &mut actix_web::dev::Payload) -> Self::Future {
        match req.cookie(T::cookie_name()) {
            Some(cookie) => match Self::try_from(cookie) {
                Ok(e) => futures::future::ok(e),
                Err(e) => futures::future::err(e),
            },
            None => futures::future::err(DouchatError::unauthorized()),
        }
    }
}

#[utoipa::path(
    get,
    path = "/token/refresh",
    tag = "Login",
    responses(
        (status = 200, description = "Successfully refresh access token"),
        (status = 401, description = "Unauthrorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError)
    )
)]
#[get("/token/refresh")]
pub async fn refresh_access_token(
    claims: DouchatJWTClaims<Refresh>,
) -> crate::error::Result<HttpResponse> {
    let claims = access_and_refresh(claims.uid, claims.id);
    Ok(HttpResponseBuilder::new(StatusCode::OK)
        .cookie(claims.0.try_into()?)
        .cookie(claims.1.try_into()?)
        .finish())
}

// TO REMOVE !!!

pub fn create_test_user(state: DouchatState) -> crate::error::Result<()> {
    if let None = state.db().get_user_by_username("Test")? {
        let new_user = NewUser::test_user();
        state.db().create_user(new_user)?;
    }
    Ok(())
}

#[get("/test_user")]
pub async fn test_user(state: Data<DouchatState>) -> crate::error::Result<HttpResponse> {
    let user = state
        .db()
        .get_user_by_username("Test")?
        .expect("Error: Test user was not created");
    let claims = access_and_refresh(user.uid, user.id);
    return Ok(response_with_token(user, claims)?);
}

#[get("/test_ws")]
pub async fn test_ws() -> HttpResponse {
    let cargo_manifest_dir = std::env::var("CARGO_MANIFEST_DIR").unwrap();
    let path = format!("{}/test_ws.html", cargo_manifest_dir);
    let contents = std::fs::read_to_string(path).unwrap();
    HttpResponseBuilder::new(StatusCode::OK)
        .content_type(ContentType::html())
        .body(contents)
}
