use actix_web::{http::StatusCode, HttpResponse, HttpResponseBuilder};
use serde::Serialize;

use crate::security::jwt::{Access, DouchatJWTClaims, Refresh};

pub fn response_with_token<T>(
    data: T,
    claims: (DouchatJWTClaims<Access>, DouchatJWTClaims<Refresh>),
) -> HttpResponse
where
    T: Serialize,
{
    let mut resp =
        HttpResponseBuilder::new(StatusCode::OK).body(serde_json::to_string(&data).unwrap());
    resp.add_cookie(&claims.0.into()).unwrap();
    resp.add_cookie(&claims.1.into()).unwrap();
    resp
}
