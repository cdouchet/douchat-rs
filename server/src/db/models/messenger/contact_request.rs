use chrono::{DateTime, Utc};
use diesel::{
    associations::{Associations, Identifiable},
    deserialize::Queryable,
    prelude::Insertable,
    BoolExpressionMethods, ExpressionMethods, JoinOnDsl, QueryDsl, RunQueryDsl, Selectable,
};
use serde::Serialize;
use uuid::Uuid;

use crate::{
    db::{models::user::User, DouchatPool},
    error::error_from_diesel::from_diesel_error,
    schema::contacts,
};
use crate::{
    error::DouchatError,
    schema::{contact_requests, users},
};

#[derive(Debug, Queryable, Selectable, Identifiable, Associations)]
#[diesel(table_name = contact_requests)]
#[diesel(belongs_to(User, foreign_key = sender))]
#[diesel(primary_key(id))]
pub struct ContactRequest {
    pub id: i32,
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    sender: i32,
    pub receiver: i32,
    pub accepted: Option<bool>,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = contact_requests)]
pub struct NewContactRequest {
    pub sender: i32,
    pub receiver: i32,
    pub accepted: Option<bool>,
}

#[derive(Debug, Serialize, Queryable, Selectable)]
#[diesel(table_name = contact_requests)]
pub struct DisplayableContactRequest {
    id: i32,
    created_at: DateTime<Utc>,
    sender: User,
}

use crate::error::Result;
use diesel::result::Error as DieselError;

use super::contact::NewContact;

impl DouchatPool {
    pub fn create_contact_request(&self, request: NewContactRequest) -> Result<ContactRequest> {
        let conn = &mut self.get_conn();
        diesel::insert_into(contact_requests::table)
            .values(request)
            .get_result::<ContactRequest>(conn)
            .map_err(from_diesel_error)
    }

    pub fn get_contact_request_by_id(&self, id: i32) -> Result<Option<ContactRequest>> {
        let conn = &mut self.get_conn();
        match contact_requests::table
            .filter(
                contact_requests::id
                    .eq(id)
                    .and(contact_requests::accepted.is_null()),
            )
            .get_result::<ContactRequest>(conn)
        {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                DieselError::NotFound => Ok(None),
                err => Err(DouchatError::from(err)),
            },
        }
    }

    /// Get contact requests sent to a given user. Return Ok(None) if user is not found
    pub fn get_user_contact_requests(
        &self,
        user_id: Uuid,
    ) -> Result<Option<Vec<DisplayableContactRequest>>> {
        let conn = &mut self.get_conn();
        let user = match self.get_user_by_uid(user_id)? {
            Some(user) => user,
            None => return Ok(None),
        };
        Ok(Some(
            users::table
                .inner_join(contact_requests::table.on(contact_requests::sender.eq(users::id)))
                .filter(contact_requests::receiver.eq(user.id))
                .select((
                    contact_requests::id,
                    contact_requests::created_at,
                    users::all_columns,
                ))
                .get_results::<DisplayableContactRequest>(conn)?,
        ))
    }

    /// Update to the ContactRequest matching the accept value. If accept is true, also create a new Contact
    pub fn respond_to_contact_request(&self, id: i32, accept: bool) -> Result<()> {
        let conn = &mut self.get_conn();
        let request = diesel::update(contact_requests::table)
            .filter(contact_requests::id.eq(id))
            .set(contact_requests::accepted.eq(accept))
            .get_result::<ContactRequest>(conn)?;
        if accept {
            diesel::insert_into(contacts::table)
                .values(vec![
                    NewContact {
                        request_id: request.id,
                        user_id: request.sender,
                        contact_id: request.receiver,
                    },
                    NewContact {
                        request_id: request.id,
                        user_id: request.receiver,
                        contact_id: request.sender,
                    },
                ])
                .execute(conn)?;
        }
        Ok(())
    }
}
