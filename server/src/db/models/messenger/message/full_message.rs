use chrono::{DateTime, Utc};
use diesel::{deserialize::Queryable, Selectable};
use serde::Serialize;
use uuid::Uuid;

use crate::db::models::messenger::room::Room;
use crate::db::models::user::User;
use crate::schema::messages;

use super::message_type::MessageType;

#[derive(Debug, Serialize, Queryable, Selectable)]
#[diesel(table_name = messages)]
pub struct FullDouchatMessage {
    #[serde(skip_serializing)]
    id: i64,
    uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    sender: User,
    room: Room,
    content: String,
    message_type: MessageType,
}
