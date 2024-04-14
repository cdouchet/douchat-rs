use actix::{Actor, Addr, Handler};

use crate::db::models::user::User;
use crate::error::Result;

use super::{parser::WebsocketContent, session::Session};

#[derive(Debug, Clone)]
pub struct Visitor {
    pub user: User,
    pub session_addr: Addr<Session>,
}

impl Actor for Visitor {
    type Context = actix::Context<Self>;
}

impl Handler<WebsocketContent> for Visitor {
    type Result = Result<()>;

    fn handle(&mut self, msg: WebsocketContent, ctx: &mut Self::Context) -> Self::Result {
        self.session_addr.do_send(msg);
        Ok(())
    }
}
