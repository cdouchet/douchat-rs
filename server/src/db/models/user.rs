use crate::db::DouchatPool;
use crate::error::{error_from_diesel::from_diesel_error, Result};
use crate::schema::users;
use chrono::{DateTime, Utc};
use diesel::{
    deserialize::Queryable, prelude::Insertable, ExpressionMethods, QueryDsl, RunQueryDsl,
};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Queryable, Serialize)]
#[diesel(table_name = users)]
pub struct User {
    id: i32,
    uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    username: String,
    photo_url: Option<String>,
    verification_date: Option<DateTime<Utc>>,
    description: Option<String>,
    status: Option<String>,
}

#[derive(Debug, Insertable, Deserialize, Serialize)]
#[diesel(table_name = users)]
pub struct NewUser {
    username: String,
    photo_url: Option<String>,
    description: Option<String>,
    status: Option<String>,
}

impl DouchatPool {
    pub fn create_user(&self, new_user: NewUser) -> Result<User> {
        let conn = &mut self.get_conn();
        diesel::insert_into(users::table)
            .values(new_user)
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_user_by_uid(&self, id: Uuid) -> Result<User> {
        let conn = &mut self.get_conn();
        users::table
            .filter(users::uid.eq(id))
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_user_by_id(&self, id: i32) -> Result<User> {
        let conn = &mut self.get_conn();
        users::table
            .filter(users::id.eq(id))
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_user_by_username<'a>(&self, username: &'a str) -> Result<User> {
        let conn = &mut self.get_conn();
        users::table
            .filter(users::username.eq(username))
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }
}
