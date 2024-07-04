use crate::db::models::user::User;
use crate::documentation::paths::{PathId, PathUsername};
use crate::error::{DouchatError, Result};
use crate::security::jwt::{Access, DouchatJWTClaims};
use actix_web::web::{Data, Json, Path};
use actix_web::{get, patch};
use uuid::Uuid;

use crate::state::DouchatState;

pub mod contact_routes;
pub mod deep_link;
pub mod devices_routes;
pub mod onboarding_routes;

// #[utoipa::path(
//     post,
//     path = "/accounts",
//     tag = "Accounts",
//     request_body = NewUser,
//     responses(
//         (status = 200, description = "Successfully created account", body = User),
//         (status = 401, description = "Bad Request", body = DouchatError),
//         (status = 500, description = "Internal Server Error", body = DouchatError)
//     )
// )]
// #[post("/accounts")]
// pub async fn create_account(
//     state: Data<DouchatState>,
//     Json(new_user): Json<NewUser>,
// ) -> Result<Json<User>> {
//     Ok(Json(state.db().create_user(new_user)?))
// }

#[utoipa::path(
    get,
    path = "/accounts/id/{id}",
    tag = "Accounts",
    params(PathId),
    responses(
        (status = 200, description = "Successfully created account", body = User),
        (status = 404, description = "Not Found"),
        (status = 401, description = "Bad Request", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError)
    )
)]
#[get("/accounts/id/{id}")]
pub async fn get_user_by_uid(
    state: Data<DouchatState>,
    path: Path<PathId>,
    _: DouchatJWTClaims<Access>,
) -> Result<Json<Option<User>>> {
    Ok(Json(
        state.db().get_user_by_uid(Uuid::parse_str(&path.id)?)?,
    ))
}

#[utoipa::path(
    get,
    path = "/accounts/username/{username}",
    tag = "Accounts",
    params(PathUsername),
    responses(
        (status = 200, description = "Successfully created account", body = User),
        (status = 404, description = "Not Found"),
        (status = 401, description = "Bad Request", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError)
    )
)]
#[get("/accounts/username/{username}")]
pub async fn get_user_by_username(
    state: Data<DouchatState>,
    path: Path<PathUsername>,
    _: DouchatJWTClaims<Access>,
) -> Result<Json<Option<User>>> {
    Ok(Json(state.db().get_user_by_username(&path.username)?))
}

#[utoipa::path(
    get,
    path = "/me",
    tag = "Accounts",
    responses(
        (status = 200, description = "Successfully created account", body = User),
        (status = 401, description = "Bad Request", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError)
    )
)]
#[get("/me")]
pub async fn me(state: Data<DouchatState>, claims: DouchatJWTClaims<Access>) -> Result<Json<User>> {
    Ok(Json(
        state
            .db()
            .get_user_by_uid(claims.uid)?
            .ok_or(DouchatError::internal_server_error())?,
    ))
}

/// Complete Onboarding
#[utoipa::path(
    patch,
    path = "/onboarding/complete",
    tag = "Accounts",
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
