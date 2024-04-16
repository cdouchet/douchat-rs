use actix_web::{
    get,
    web::{Data, Json, Query},
};
use serde::Deserialize;
use uuid::Uuid;

use crate::{
    db::models::{
        messenger::{message::DouchatMessage, room::Room},
        user::User,
    },
    error::{DouchatError, Result},
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

#[get("/rooms")]
pub async fn get_user_rooms(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
) -> Result<Json<Vec<Room>>> {
    Ok(Json(
        state
            .db()
            .get_user_rooms(claims.uid)?
            .ok_or(DouchatError::unauthorized())?,
    ))
}

#[derive(Deserialize)]
pub struct GetRoomMessagesQuery {
    room_id: Uuid,
    limit: i64,
    skip: i64,
}

#[get("/rooms/messages")]
pub async fn get_room_messages(
    claims: DouchatJWTClaims<Access>,
    state: Data<DouchatState>,
    query: Query<GetRoomMessagesQuery>,
) -> Result<Json<Vec<DouchatMessage>>> {
    state.db().is_user_in_room(claims.uid, query.room_id)?;
    Ok(Json(
        state
            .db()
            .get_room_messages_with_limit(query.room_id, query.limit, query.skip)?
            .ok_or(DouchatError::not_found(Some(format!(
                "No room with id {}",
                query.room_id
            ))))?,
    ))
}

#[get("/contacts")]
pub async fn get_user_contacts(
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
