use std::time::{Duration, SystemTime, UNIX_EPOCH};

use crate::env::{JWT_ISSUER, JWT_SECRET};
use actix_web::{
    cookie::{time::OffsetDateTime, Cookie, CookieBuilder},
    FromRequest,
};
use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
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
    uid: Uuid,
    r#type: T,
}

impl<'a, T: DouchatTokenType + Deserialize<'static>> DouchatJWTClaims<T> {
    pub fn new(uid: Uuid, r#type: T) -> Self {
        let now_timer = SystemTime::now();
        let timer = now_timer + Duration::from_secs(605800);
        Self {
            exp: timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            iat: now_timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            uid,
            iss: JWT_ISSUER.to_string(),
            r#type,
        }
    }
}

pub fn access_and_refresh(uid: Uuid) -> (DouchatJWTClaims<Access>, DouchatJWTClaims<Refresh>) {
    (
        DouchatJWTClaims::new(uid, Access),
        DouchatJWTClaims::new(uid, Refresh),
    )
}

impl<T: DouchatTokenType + DeserializeOwned + 'static> TryFrom<Cookie<'static>>
    for DouchatJWTClaims<T>
{
    type Error = DouchatError;

    fn try_from(value: Cookie<'static>) -> Result<Self, Self::Error> {
        let decoding_key = DecodingKey::from_secret(JWT_SECRET.as_bytes());
        let validation = Validation::new(Algorithm::RS256);
        decode::<Self>(value.value(), &decoding_key, &validation)
            .map(|e| e.claims)
            .map_err(from_jwt_error)
    }
}

impl<T: DouchatTokenType + Deserialize<'static>> Into<Cookie<'static>> for DouchatJWTClaims<T> {
    fn into(self) -> Cookie<'static> {
        let expires = OffsetDateTime::now_utc() + Duration::from_secs(T::validity());
        CookieBuilder::new(T::cookie_name(), serde_json::to_string(&self).unwrap())
            .secure(true)
            .http_only(true)
            .expires(expires)
            .finish()
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
