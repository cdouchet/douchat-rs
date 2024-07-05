use std::io::Read;

use crate::{
    db::models::user_picture::{NewUserPicture, UserPicture, UserPictureMultipart},
    error::Result,
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};
use actix_multipart::form::MultipartForm;
use actix_web::{
    patch, put,
    web::{Data, Json},
};
use serde::Deserialize;
use utoipa::ToSchema;

#[derive(Deserialize, ToSchema)]
pub struct UsernameUpdateForm {
    username: String,
}

/// Update Username
#[utoipa::path(
    patch,
    path = "/username",
    tag = "Onboarding",
    request_body = UsernameUpdateForm,
    responses(
        (status = 200, description = "Successfully updated username", body = String),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[patch("/username")]
pub async fn update_username(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
    Json(body): Json<UsernameUpdateForm>,
) -> Result<String> {
    state.db().update_username(claims.id, body.username)?;
    Ok(String::from("OK"))
}

#[utoipa::path(
    put,
    path = "/user/picture",
    tag = "Onboarding",
    request_body(content = UserPictureMultipart, content_type = "multipart/form-data"),
    responses(
        (status = 200, description = "Successfully upserted user picture", body = UserPicture),
        (status = 400, description = "Bad Request", body = DouchatError),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[put("/user/picture")]
pub async fn upload_user_picture(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
    MultipartForm(form): MultipartForm<UserPictureMultipart>,
) -> Result<String> {
    state.db().insert_user_picture(NewUserPicture {
        user_id: claims.id,
        image_data: form.file.file.bytes().map(|e| e.unwrap()).collect(),
    })?;
    Ok(String::from("OK"))
}

/// Complete Onboarding
#[utoipa::path(
    patch,
    path = "/onboarding/complete",
    tag = "Onboarding",
    responses(
        (status = 200, description = "OK", body = String),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[patch("/onboarding/complete")]
pub async fn complete_onboarding(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
) -> Result<String> {
    state.db().complete_onboarding(claims.id)?;
    Ok(String::from("Completed"))
}
