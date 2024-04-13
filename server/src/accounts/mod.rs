use crate::db::models::user::{NewUser, User};
use crate::error::Result;
use actix_web::get;
use actix_web::{
    post,
    web::{Data, Json, Path},
};
use uuid::Uuid;

use crate::state::DouchatState;

#[post("/accounts")]
pub async fn create_account(
    state: Data<DouchatState>,
    Json(new_user): Json<NewUser>,
) -> Result<Json<User>> {
    Ok(Json(state.db().create_user(new_user)?))
}

#[get("/accounts/id/{id}")]
pub async fn get_user_by_uid(state: Data<DouchatState>, uid: Path<String>) -> Result<Json<User>> {
    Ok(Json(state.db().get_user_by_uid(Uuid::parse_str(&uid)?)?))
}

#[get("/accounts/username/{username}")]
pub async fn get_user_by_username(
    state: Data<DouchatState>,
    username: Path<String>,
) -> Result<Json<User>> {
    Ok(Json(state.db().get_user_by_username(&username)?))
}
