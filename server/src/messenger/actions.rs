use crate::db::models::user::User;
use crate::error::DouchatError;
use actix::{Addr, Message};
use uuid::Uuid;

use super::session::Session;

#[derive(Message)]
#[rtype(result = "Result<(), DouchatError>")]
pub struct Connect {
    pub user: User,
    pub addr: Addr<Session>,
}

#[derive(Message)]
#[rtype(result = "Result<(), DouchatError>")]
pub struct Disconnect {
    pub uid: Uuid,
}
