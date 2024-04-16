use chrono::{DateTime, Utc};
use diesel::{
    associations::{Associations, Identifiable},
    deserialize::Queryable,
    prelude::Insertable,
    ExpressionMethods, JoinOnDsl, QueryDsl, RunQueryDsl, Selectable,
};
use serde::Serialize;
use uuid::Uuid;

use crate::schema::{contacts, users};
use crate::{
    db::{models::user::User, DouchatPool},
    error::error_from_diesel::from_diesel_error,
};

#[derive(Debug, Queryable, Identifiable, Selectable, Associations, Serialize)]
#[diesel(table_name = contacts)]
#[diesel(belongs_to(User, foreign_key = user_id))]
#[diesel(primary_key(user_id, contact_id))]
pub struct Contact {
    #[serde(skip_serializing)]
    created_at: DateTime<Utc>,
    #[serde(skip_serializing)]
    updated_at: DateTime<Utc>,
    user_id: i32,
    contact_id: i32,
    #[serde(skip_serializing)]
    request_id: i32,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = contacts)]
pub struct NewContact {
    pub user_id: i32,
    pub contact_id: i32,
    pub request_id: i32,
}

use crate::error::Result;

impl DouchatPool {
    pub fn create_contact(&self, new_contact: NewContact) -> Result<Contact> {
        let conn = &mut self.get_conn();
        diesel::insert_into(contacts::table)
            .values(new_contact)
            .get_result::<Contact>(conn)
            .map_err(from_diesel_error)
    }

    /// Get contacts of a given user. Returns Ok(None) if the given user does not exists
    pub fn get_user_contacts(&self, user_id: Uuid) -> Result<Option<Vec<User>>> {
        let conn = &mut self.get_conn();
        let user = match self.get_user_by_uid(user_id)? {
            Some(user) => user,
            None => return Ok(None),
        };
        Ok(Some(
            users::table
                .inner_join(contacts::table.on(contacts::contact_id.eq(users::id)))
                .filter(contacts::user_id.eq(user.id))
                .select(users::all_columns)
                .get_results::<User>(conn)?,
        ))
    }
}
