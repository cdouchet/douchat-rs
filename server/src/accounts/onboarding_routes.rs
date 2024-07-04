use crate::{
    error::Result,
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};
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
