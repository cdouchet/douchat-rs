pub mod room_type;
pub mod room_user;

use chrono::{DateTime, Utc};
use diesel::associations::Identifiable;
use diesel::{deserialize::Queryable, prelude::Insertable};
use diesel::{BelongingToDsl, BoolExpressionMethods, ExpressionMethods, QueryDsl, RunQueryDsl};
use serde::Serialize;
use uuid::Uuid;

use self::room_type::RoomType;
use self::room_user::RoomUser;

use crate::error::error_from_diesel::from_diesel_error;
use crate::schema::room_users;
use crate::{db::DouchatPool, schema::rooms};

#[derive(Debug, Serialize, Queryable, Identifiable)]
#[diesel(table_name = rooms)]
pub struct Room {
    pub id: i32,
    uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    name: String,
    description: String,
    room_type: RoomType,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = rooms)]
pub struct NewRoom {
    name: String,
    description: String,
    room_type: RoomType,
}

use crate::error::{DouchatError, Result};
use diesel::result::Error as DieselError;

impl DouchatPool {
    pub fn create_room(&self, new_room: NewRoom) -> Result<Room> {
        let conn = &mut self.get_conn();
        diesel::insert_into(rooms::table)
            .values(new_room)
            .get_result::<Room>(conn)
            .map_err(from_diesel_error)
    }

    /// Get room by Uuid. Returns Ok(None) if no Room is found.
    pub fn get_room_by_uid(&self, uid: Uuid) -> Result<Option<Room>> {
        let conn = &mut self.get_conn();
        match rooms::table
            .filter(rooms::uid.eq(uid))
            .get_result::<Room>(conn)
        {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                DieselError::NotFound => Ok(None),
                e => Err(DouchatError::from(e)),
            },
        }
    }

    pub fn get_user_rooms(&self, user_id: Uuid) -> Result<Option<Vec<Room>>> {
        let conn = &mut self.get_conn();
        let user = match self.get_user_by_uid(user_id)? {
            Some(user) => user,
            None => return Ok(None),
        };
        let res = RoomUser::belonging_to(&user)
            .inner_join(rooms::table)
            .select(rooms::all_columns)
            .load(conn)?;
        Ok(Some(res))
    }

    pub fn is_user_in_room(&self, user_id: Uuid, room_id: Uuid) -> Result<()> {
        let conn = &mut self.get_conn();
        let user = self
            .get_user_by_uid(user_id)?
            .ok_or(DouchatError::unauthorized())?;
        let room = match self.get_room_by_uid(room_id)? {
            Some(room) => room,
            None => return Err(DouchatError::unauthorized()),
        };
        match room_users::table
            .filter(
                room_users::room
                    .eq(room.id)
                    .and(room_users::user_id.eq(user.id)),
            )
            .get_result::<RoomUser>(conn)
        {
            Ok(_) => Ok(()),
            Err(e) => match e {
                DieselError::NotFound => Err(DouchatError::unauthorized()),
                e => Err(DouchatError::from(e)),
            },
        }
    }
}
