use actix_web::{
    http::{header::ContentType, StatusCode},
    HttpResponse, HttpResponseBuilder,
};
use serde::Serialize;

use crate::error::Result;
use crate::security::jwt::{Access, DouchatJWTClaims, Refresh};

pub fn response_with_token<T>(
    data: T,
    claims: (DouchatJWTClaims<Access>, DouchatJWTClaims<Refresh>),
) -> Result<HttpResponse>
where
    T: Serialize,
{
    let mut resp = HttpResponseBuilder::new(StatusCode::OK)
        .append_header(ContentType::json())
        .body(serde_json::to_string(&data).unwrap());

    resp.add_cookie(&claims.0.try_into()?).unwrap();
    resp.add_cookie(&claims.1.try_into()?).unwrap();
    Ok(resp)
}
