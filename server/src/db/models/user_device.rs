use crate::db::{models::user::User, DouchatPool};
use crate::error::{DouchatError, Result};
use crate::schema::user_devices;
use chrono::{DateTime, Utc};
use diesel::{associations::Associations, deserialize::Queryable, prelude::Insertable};
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};
use serde::Serialize;
use utoipa::ToSchema;

#[derive(Debug, Serialize, Queryable, Associations, ToSchema)]
#[diesel(belongs_to(User, foreign_key = user_id))]
#[diesel(table_name = user_devices)]
pub struct UserDevice {
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    id: i64,
    #[serde(skip_serializing)]
    user_id: i32,
    device_id: String,
    device_name: String,
}

#[derive(Debug)]
pub struct UserDeviceList(pub Vec<UserDevice>);

#[derive(Insertable)]
#[diesel(table_name = user_devices)]
pub struct NewUserDevice {
    pub user_id: i32,
    pub device_id: String,
    pub device_name: String,
}

impl NewUserDevice {
    pub fn test_device() -> Self {
        Self {
            user_id: 1,
            device_id: "test_device".to_string(),
            device_name: "Douchat Test Device".to_string(),
        }
    }
}

impl DouchatPool {
    pub fn insert_device(&self, new_device: NewUserDevice) -> Result<UserDevice> {
        let conn = &mut self.get_conn();
        println!("1");
        let res = diesel::insert_into(user_devices::table)
            .values(&new_device)
            .on_conflict(user_devices::device_id)
            .do_update()
            .set((
                user_devices::updated_at.eq(Utc::now()),
                user_devices::device_name.eq(&new_device.device_name),
                user_devices::user_id.eq(&new_device.user_id),
            ))
            .get_result::<UserDevice>(conn)?;
        println!("2");
        Ok(res)
    }

    pub fn get_device_by_device_id<'a>(&self, device_id: &'a str) -> Result<Option<UserDevice>> {
        let conn = &mut self.get_conn();
        let res = user_devices::table
            .filter(user_devices::device_id.eq(device_id))
            .get_result::<UserDevice>(conn);
        match res {
            Ok(e) => Ok(Some(e)),
            Err(err) => match err {
                diesel::result::Error::NotFound => Ok(None),
                e => Err(DouchatError::from(e)),
            },
        }
    }

    pub fn get_user_devices(&self, user_id: i32) -> Result<UserDeviceList> {
        let conn = &mut self.get_conn();
        let res = user_devices::table
            .filter(user_devices::user_id.eq(user_id))
            .get_results::<UserDevice>(conn)?;
        Ok(UserDeviceList(res))
    }
}
