use chrono::{DateTime, Utc};
use diesel::{
    associations::{Associations, Identifiable},
    deserialize::Queryable,
    prelude::Insertable,
    Selectable,
};

use crate::db::models::{messenger::room::Room, user::User};
use crate::schema::room_users;

#[derive(Debug, Identifiable, Associations, Queryable, Selectable)]
#[diesel(table_name = room_users)]
#[diesel(belongs_to(User))]
#[diesel(belongs_to(Room, foreign_key = room))]
pub struct RoomUser {
    id: i32,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    user_id: i32,
    room: i32,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = room_users)]
pub struct NewRoomUser {
    user_id: i32,
    room: i32,
}
