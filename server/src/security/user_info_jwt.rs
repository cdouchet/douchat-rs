use std::time::{Duration, SystemTime, UNIX_EPOCH};

use actix_web::{
    cookie::{time::OffsetDateTime, Cookie, CookieBuilder},
    get,
    http::StatusCode,
    web::{Data, Json},
    FromRequest, HttpResponse, HttpResponseBuilder,
};
use diesel::{deserialize::Queryable, ExpressionMethods, QueryDsl, RunQueryDsl};
use jsonwebtoken::{decode, DecodingKey, Validation};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;

use crate::{
    db::models::user::User,
    env::{JWT_ISSUER, JWT_SECRET},
    error::{error_from_jwt::from_jwt_error, DouchatError},
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

#[derive(Debug, Serialize, Deserialize, ToSchema)]
pub struct UserInfoJWTClaims {
    iat: u64,
    exp: u64,
    iss: String,
    user_info_lookup: Uuid,
}

impl UserInfoJWTClaims {
    pub fn new(uid: Uuid) -> Self {
        let now_timer = SystemTime::now();
        let timer = now_timer + Duration::from_secs(60 * 5);
        Self {
            exp: timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            iat: now_timer.duration_since(UNIX_EPOCH).unwrap().as_secs(),
            iss: JWT_ISSUER.to_string(),
            user_info_lookup: uid,
        }
    }
}

impl<'a> TryFrom<Cookie<'a>> for UserInfoJWTClaims {
    type Error = DouchatError;

    fn try_from(value: Cookie<'a>) -> Result<Self, Self::Error> {
        let decoding_key = DecodingKey::from_secret(JWT_SECRET.as_bytes());
        let validation = Validation::default();
        decode::<Self>(value.value(), &decoding_key, &validation)
            .map(|e| e.claims)
            .map_err(from_jwt_error)
    }
}

impl<'a> TryInto<Cookie<'a>> for UserInfoJWTClaims {
    type Error = DouchatError;

    fn try_into(self) -> Result<Cookie<'a>, Self::Error> {
        let expires = OffsetDateTime::now_utc() + Duration::from_secs(60 * 5);
        let header = jsonwebtoken::Header::default();
        let encoding_key = jsonwebtoken::EncodingKey::from_secret(JWT_SECRET.as_bytes());
        let jwt = jsonwebtoken::encode(&header, &self, &encoding_key)?;
        Ok(CookieBuilder::new("user_info_token", jwt)
            .path("/")
            .secure(true)
            .http_only(true)
            .expires(expires)
            .finish())
    }
}

impl FromRequest for UserInfoJWTClaims {
    type Error = DouchatError;
    type Future = futures::future::Ready<Result<Self, Self::Error>>;

    fn from_request(req: &actix_web::HttpRequest, _: &mut actix_web::dev::Payload) -> Self::Future {
        match req.cookie("user_info_token") {
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
    path = "/user/info_token",
    tag = "Accounts",
    responses(
        (status = 200, description = "Successfully fetched user_info_token as cookie", body = String),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[get("/user/info_token")]
pub async fn get_user_info_token(
    claims: DouchatJWTClaims<Access>,
) -> crate::error::Result<HttpResponse> {
    let user_info_claims = UserInfoJWTClaims::new(claims.uid);
    let cookie: Cookie = user_info_claims.try_into()?;
    let response = HttpResponseBuilder::new(StatusCode::OK)
        .cookie(cookie)
        .body("OK");
    Ok(response)
}

#[derive(Debug, Queryable, Serialize, Deserialize, ToSchema)]
pub struct UserInfo {
    uid: Uuid,
    username: Option<String>,
    photo_url: Option<String>,
}

#[utoipa::path(
    get,
    path = "/user/info_token/data",
    tag = "Accounts",
    responses(
        (status = 200, description = "Successfully fetched user_info_token as cookie", body = UserInfo),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 403, description = "Forbidden", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[get("/user/info_token/data")]
pub async fn get_info_from_user_info_token(
    state: Data<DouchatState>,
    claims: UserInfoJWTClaims,
) -> crate::error::Result<Json<UserInfo>> {
    use crate::schema::users;
    let conn = &mut state.db().get_conn();
    let res = users::table
        .select((users::uid, users::username, users::photo_url))
        .filter(users::uid.eq(claims.user_info_lookup))
        .get_result::<UserInfo>(conn)?;
    Ok(Json(res))
}
