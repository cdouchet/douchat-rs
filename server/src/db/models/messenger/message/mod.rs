use chrono::{DateTime, Utc};
use diesel::associations::Identifiable;
use diesel::{associations::Associations, deserialize::Queryable, prelude::Insertable};
use diesel::{BelongingToDsl, ExpressionMethods, QueryDsl, RunQueryDsl};
use serde::Serialize;
use uuid::Uuid;

use crate::db::models::{messenger::room::Room, user::User};
use crate::db::DouchatPool;
use crate::error::error_from_diesel::from_diesel_error;
use crate::schema::messages;

pub mod full_message;
pub mod message_type;

#[derive(Debug, Serialize, Queryable, Identifiable, Associations)]
#[diesel(table_name = messages)]
#[diesel(belongs_to(User, foreign_key = sender))]
#[diesel(belongs_to(Room, foreign_key = room))]
pub struct DouchatMessage {
    id: i64,
    uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    sender: i32,
    room: i32,
    content: String,
    message_type: MessageType,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = messages)]
pub struct NewDouchatMessage {
    sender: i32,
    room: i32,
    content: String,
}

use crate::error::Result;

use self::message_type::MessageType;

impl DouchatPool {
    /// Creates a new message from a NewDouchatMessage
    pub fn create_message(&self, new_message: NewDouchatMessage) -> Result<DouchatMessage> {
        let conn = &mut self.get_conn();
        diesel::insert_into(messages::table)
            .values(new_message)
            .get_result::<DouchatMessage>(conn)
            .map_err(from_diesel_error)
    }

    /// Get messages from a room by most recent. Returns Ok(None) if no room exists with given id
    pub fn get_room_messages(&self, room_id: Uuid) -> Result<Option<Vec<DouchatMessage>>> {
        let conn = &mut self.get_conn();
        let room = match self.get_room_by_uid(room_id)? {
            Some(room) => room,
            None => return Ok(None),
        };
        let res = DouchatMessage::belonging_to(&room)
            .order(messages::created_at.desc())
            .load(conn)?;
        Ok(Some(res))
    }

    /// Get messages from a room by most recent with limit and skip parameters. Returns Ok(None) if no rooms exists with given id
    pub fn get_room_messages_with_limit(
        &self,
        room_id: Uuid,
        limit: i64,
        skip: i64,
    ) -> Result<Option<Vec<DouchatMessage>>> {
        let conn = &mut self.get_conn();
        let room = match self.get_room_by_uid(room_id)? {
            Some(room) => room,
            None => return Ok(None),
        };
        let res = DouchatMessage::belonging_to(&room)
            .order(messages::created_at.desc())
            .offset(skip)
            .limit(limit)
            .load(conn)?;
        Ok(Some(res))
    }
}
