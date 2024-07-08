use actix_web::{
    get,
    http::{header::ContentType, StatusCode},
    web::{Data, Query},
    HttpResponse,
};
use serde::Deserialize;
use utoipa::{IntoParams, ToSchema};
use uuid::Uuid;

use crate::{
    error::{DouchatError, Result},
    state::DouchatState,
};

#[derive(Deserialize, IntoParams, ToSchema)]
pub struct QueryUid {
    uid: Uuid,
}

#[utoipa::path(
    get,
    path = "/user/picture/{uid}",
    tag = "Cdn",
    params(QueryUid),
    responses(
        (status = 200, description = "Successfully fetched user picture", content_type = "application/octet-stream"),
        (status = 400, description = "Bad Request", body = DouchatError),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 404, description = "Not Found", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[get("/user/picture/{uid}.jpg")]
pub async fn get_user_picture(
    state: Data<DouchatState>,
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
