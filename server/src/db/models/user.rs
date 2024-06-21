use crate::db::DouchatPool;
use crate::error::DouchatError;
use crate::error::{error_from_diesel::from_diesel_error, Result};
use crate::oauth::apple::{AppleIdTokenClaims, AppleOauthPayload};
use crate::oauth::google::GoogleIdentityResponse;
use crate::schema::users;
use chrono::{DateTime, Utc};
use diesel::associations::Identifiable;
use diesel::{
    deserialize::Queryable, prelude::Insertable, ExpressionMethods, QueryDsl, RunQueryDsl,
};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;

#[derive(Debug, Identifiable, Queryable, Serialize, Clone, ToSchema)]
#[diesel(table_name = users)]
#[allow(dead_code)]
pub struct User {
    #[serde(skip_serializing)]
    pub id: i32,
    pub uid: Uuid,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    #[serde(skip_deserializing)]
    email: String,
    username: Option<String>,
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
    pub username: Option<String>,
    photo_url: Option<String>,
    #[serde(skip_deserializing)]
    pub verification_date: Option<DateTime<Utc>>,
    description: Option<String>,
    status: Option<String>,
}

impl NewUser {
    pub fn test_user() -> Self {
        Self {
            email: String::from("test@test.test"),
            username: Some(String::from("Test")),
            photo_url: None,
            verification_date: None,
            description: Some(String::from("Testeur")),
            status: None,
        }
    }
}

impl From<(AppleOauthPayload, AppleIdTokenClaims)> for NewUser {
    fn from(value: (AppleOauthPayload, AppleIdTokenClaims)) -> Self {
        Self {
            email: value.1.email,
            description: None,
            username: Some(value.0.user.unwrap().name.join()),
            photo_url: None,
            verification_date: Some(Utc::now()),
            status: None,
        }
    }
}

impl From<GoogleIdentityResponse> for NewUser {
    fn from(value: GoogleIdentityResponse) -> Self {
        Self {
            email: value.email,
            description: None,
            username: Some(value.name),
            photo_url: Some(value.picture),
            status: None,
            verification_date: Some(Utc::now()),
        }
    }
}

use diesel::result::Error as DieselError;

impl DouchatPool {
    pub fn create_user(&self, new_user: NewUser) -> Result<User> {
        let conn = &mut self.get_conn();
        diesel::insert_into(users::table)
            .values(new_user)
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_user_by_uid(&self, id: Uuid) -> Result<Option<User>> {
        let conn = &mut self.get_conn();
        match users::table
            .filter(users::uid.eq(id))
            .get_result::<User>(conn)
        {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                DieselError::NotFound => Ok(None),
                err => Err(DouchatError::from(err)),
            },
        }
    }

    pub fn get_user_by_id(&self, id: i32) -> Result<User> {
        let conn = &mut self.get_conn();
        users::table
            .filter(users::id.eq(id))
            .get_result::<User>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_user_by_username<'a>(&self, username: &'a str) -> Result<Option<User>> {
        let conn = &mut self.get_conn();
        let res = users::table
            .filter(users::username.eq(username))
            .get_result::<User>(conn);
        match res {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                diesel::result::Error::NotFound => Ok(None),
                e => Err(DouchatError::from(e)),
            },
        }
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
