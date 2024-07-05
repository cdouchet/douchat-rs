use actix_web::{
    get,
    http::{header::ContentType, StatusCode},
    web::{Data, Query},
    HttpResponse,
};
use serde::Deserialize;
use uuid::Uuid;

use crate::{
    error::{DouchatError, Result},
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

#[derive(Deserialize)]
pub struct QueryUid {
    uid: Uuid,
}

#[get("/user/picture/{uid}")]
pub async fn get_user_picture(
    state: Data<DouchatState>,
    _: DouchatJWTClaims<Access>,
    Query(query): Query<QueryUid>,
) -> Result<HttpResponse> {
    let user_picture = state
        .db()
        .get_user_picture_from_uid(query.uid)?
        .ok_or(DouchatError::not_found(None))?;
    Ok(HttpResponse::build(StatusCode::OK)
        .content_type(ContentType::jpeg())
        .body(user_picture.image_data))
}
