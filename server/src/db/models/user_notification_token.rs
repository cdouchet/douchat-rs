use crate::db::models::{user::User, user_device::UserDevice};
use crate::db::DouchatPool;
use crate::error::Result;
use crate::schema::user_notification_token;
use chrono::{DateTime, Utc};
use diesel::prelude::Insertable;
use diesel::{associations::Associations, deserialize::Queryable};
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};

#[derive(Debug, Queryable, Associations)]
#[diesel(belongs_to(User, foreign_key = user_id))]
#[diesel(belongs_to(UserDevice, foreign_key = device_id))]
#[diesel(table_name = user_notification_token)]
pub struct UserNotificationToken {
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    id: i64,
    user_id: i32,
    device_id: i64,
    token: String,
}

#[derive(Debug, Insertable)]
#[diesel(table_name = user_notification_token)]
pub struct NewUserNotificationToken {
    pub user_id: i32,
    pub device_id: i64,
    pub token: String,
}

impl DouchatPool {
    pub fn insert_user_notification_token(
        &self,
        new_user_notification_token: NewUserNotificationToken,
    ) -> Result<UserNotificationToken> {
        let conn = &mut self.get_conn();
        let res = diesel::insert_into(user_notification_token::table)
            .values(&new_user_notification_token)
            .on_conflict(user_notification_token::device_id)
            .do_update()
            .set((
                user_notification_token::updated_at.eq(Utc::now()),
                user_notification_token::device_id.eq(&new_user_notification_token.device_id),
                user_notification_token::token.eq(&new_user_notification_token.token),
                user_notification_token::user_id.eq(&new_user_notification_token.user_id),
            ))
            .get_result::<UserNotificationToken>(conn)?;
        Ok(res)
    }

    pub fn get_device_notification_token(&self, device_id: i64) -> Result<UserNotificationToken> {
        let conn = &mut self.get_conn();
        let res = user_notification_token::table
            .filter(user_notification_token::device_id.eq(device_id))
            .get_result::<UserNotificationToken>(conn)?;
        Ok(res)
    }
}
