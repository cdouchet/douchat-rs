use crate::db::models::user::User;
use crate::db::DouchatPool;
use crate::error::{DouchatError, Result};
use crate::schema::user_pictures;
use actix_multipart::form::tempfile::TempFile;
use actix_multipart::form::MultipartForm;
use chrono::{DateTime, Utc};
use diesel::associations::Identifiable;
use diesel::{associations::Associations, deserialize::Queryable, prelude::Insertable};
use diesel::{BelongingToDsl, ExpressionMethods, RunQueryDsl};
use utoipa::ToSchema;
use uuid::Uuid;

#[derive(Identifiable, Queryable, Associations, Debug, ToSchema, Clone)]
#[diesel(belongs_to(User, foreign_key = user_id))]
#[diesel(table_name = user_pictures)]
pub struct UserPicture {
    created_at: DateTime<Utc>,
    updated_at: DateTime<Utc>,
    id: i64,
    user_id: i32,
    pub image_data: Vec<u8>,
}

#[derive(Debug, Insertable, Clone)]
#[diesel(table_name = user_pictures)]
pub struct NewUserPicture {
    pub user_id: i32,
    pub image_data: Vec<u8>,
}

#[derive(Debug, MultipartForm, ToSchema)]
pub struct UserPictureMultipart {
    #[multipart(limit = "50MB")]
    #[schema(value_type = String, format = Binary)]
    pub file: TempFile,
}

impl DouchatPool {
    pub fn insert_user_picture(&self, new_user_picture: NewUserPicture) -> Result<UserPicture> {
        let conn = &mut self.get_conn();
        let res = diesel::insert_into(user_pictures::table)
            .values(new_user_picture.clone())
            .on_conflict(user_pictures::user_id)
            .do_update()
            .set(user_pictures::image_data.eq(new_user_picture.image_data))
            .get_result::<UserPicture>(conn)?;
        Ok(res)
    }

    pub fn get_user_picture_from_uid(&self, uid: Uuid) -> Result<Option<UserPicture>> {
        let user = self
            .get_user_by_uid(uid)?
            .ok_or(DouchatError::not_found(None))?;
        let conn = &mut self.get_conn();
        let res: Vec<UserPicture> = UserPicture::belonging_to(&user).load(conn)?;
        if res.is_empty() {
            return Ok(None);
        }
        let res = res.first().unwrap();
        Ok(Some(res.clone()))
    }
}
