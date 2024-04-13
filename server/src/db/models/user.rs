use crate::db::DouchatPool;
use crate::error::DouchatError;
use crate::error::{error_from_diesel::from_diesel_error, Result};
use crate::oauth::apple::{AppleIdTokenClaims, AppleOauthPayload, AppleUser};
use crate::schema::users;
use chrono::{DateTime, Utc};
use diesel::{
    deserialize::Queryable, prelude::Insertable, ExpressionMethods, QueryDsl, RunQueryDsl,
};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Queryable, Serialize)]
#[diesel(table_name = users)]
#[allow(dead_code)]
pub struct User {
    #[serde(skip_serializing)]
    id: i32,
    pub uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    email: String,
    username: String,
    photo_url: Option<String>,
    verification_date: Option<DateTime<Utc>>,
    description: Option<String>,
    status: Option<String>,
}

#[derive(Debug, Insertable, Deserialize, Serialize)]
#[diesel(table_name = users)]
pub struct NewUser {
    #[serde(skip_deserializing)]
    email: String,
    username: String,
    photo_url: Option<String>,
    description: Option<String>,
    status: Option<String>,
}

impl From<(AppleOauthPayload, AppleIdTokenClaims)> for NewUser {
    fn from(value: (AppleOauthPayload, AppleIdTokenClaims)) -> Self {
        Self {
            email: value.1.email,
            description: None,
            username: serde_json::from_str::<AppleUser>(&value.0.user.unwrap())
                .unwrap()
                .name
                .join(),
            photo_url: None,
            status: None,
        }
    }
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
        let res = users::table
            .filter(users::username.eq(username))
            .get_result::<User>(conn)
            .map_err(from_diesel_error);
        res
    }

    pub fn email_exists<'a>(&self, email: &'a str) -> Result<Option<User>> {
        let conn = &mut self.get_conn();
        let res = users::table
            .filter(users::email.eq(email))
            .get_result::<User>(conn);
        match res {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                diesel::result::Error::NotFound => Ok(None),
                e => Err(DouchatError::from(e)),
            },
        }
    }
}
