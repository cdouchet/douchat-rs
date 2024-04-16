use actix_web::{
    get, post, put,
    web::{Data, Json},
};
use serde::Deserialize;
use uuid::Uuid;

use crate::{
    db::models::{
        messenger::contact_request::{DisplayableContactRequest, NewContactRequest},
        user::User,
    },
    error::{DouchatError, Result},
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

#[derive(Debug, Deserialize)]
struct ContactForm {
    contact_id: Uuid,
}

#[put("/contacts/requests")]
pub async fn create_contact_request(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
    Json(form): Json<ContactForm>,
) -> Result<String> {
    state.db().create_contact_request(NewContactRequest {
        sender: claims.id,
        receiver: state
            .db()
            .get_user_by_uid(form.contact_id)?
            .ok_or(DouchatError::not_found(Some(format!(
                "User with id {} does not exists",
                form.contact_id
            ))))?
            .id,
        accepted: None,
    })?;
    Ok(String::from("OK"))
}

#[derive(Debug, Deserialize)]
pub struct RespondToContactRequestForm {
    request_id: i32,
    accept: bool,
}

#[post("/contacts/requests/respond")]
pub async fn respond_to_contact_request(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
    Json(form): Json<RespondToContactRequestForm>,
) -> Result<String> {
    let request = state
        .db()
        .get_contact_request_by_id(form.request_id)?
        .ok_or(DouchatError::not_found(Some(format!(
            "No request with id {}",
            form.request_id
        ))))?;
    if request.receiver != claims.id || request.accepted.is_some() {
        return Err(DouchatError::unauthorized());
    }
    state
        .db()
        .respond_to_contact_request(request.id, form.accept)?;
    Ok(String::from("OK"))
}

#[get("/contacts/requests")]
pub async fn get_contact_requests(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
) -> Result<Json<Vec<DisplayableContactRequest>>> {
    Ok(Json(
        state
            .db()
            .get_user_contact_requests(claims.uid)?
            .ok_or(DouchatError::unauthorized())?,
    ))
}

#[get("/contacts")]
pub async fn get_contacts(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
) -> Result<Json<Vec<User>>> {
    Ok(Json(
        state
            .db()
            .get_user_contacts(claims.uid)?
            .ok_or(DouchatError::unauthorized())?,
    ))
}
