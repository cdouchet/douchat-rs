use actix::{Actor, Addr, Handler};
use actix_web::{get, HttpRequest, HttpResponse};

use crate::{
    error::DouchatError,
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

use self::{
    actions::{Connect, Disconnect},
    parser::WebsocketContent,
    session::Session,
    visitor::Visitor,
};

pub mod actions;
pub mod messenger_routes;
pub mod notification_service;
pub mod parser;
pub mod room;
pub mod session;
pub mod visitor;

#[derive(Debug, Clone)]
pub struct Messenger {
    users: Vec<Visitor>,
}

impl Messenger {
    pub fn new() -> Self {
        Self { users: Vec::new() }
    }
}

impl Actor for DouchatState {
    type Context = actix::Context<Self>;
}

impl Handler<Connect> for DouchatState {
    type Result = Result<(), DouchatError>;

    fn handle(&mut self, msg: Connect, _: &mut Self::Context) -> Self::Result {
        let messenger = &mut self.messenger_mut();
        if !messenger.users.iter().any(|e| e.user.uid == msg.user.uid) {
            println!("Adding new user");
            messenger.users.push(Visitor {
                user: msg.user,
                session_addr: msg.addr,
            });
            println!("Connected users are: {:?}", messenger.users);
        } else {
            println!("User already in messenger");
        }
        Ok(())
    }
}

impl Handler<Disconnect> for DouchatState {
    type Result = Result<(), DouchatError>;

    fn handle(&mut self, msg: Disconnect, _: &mut Self::Context) -> Self::Result {
        let messenger = &mut self.messenger_mut();
        messenger.users.retain(|e| e.user.uid != msg.uid);
        println!("User with id {} disconnected", msg.uid);
        Ok(())
    }
}

impl Handler<WebsocketContent> for DouchatState {
    type Result = Result<(), DouchatError>;

    fn handle(&mut self, msg: WebsocketContent, ctx: &mut Self::Context) -> Self::Result {
        for user in &self.messenger().users {
            user.session_addr.do_send(msg.clone());
        }
        Ok(())
    }
}

#[get("/ws")]
pub async fn ws(
    req: HttpRequest,
    stream: actix_web::web::Payload,
    state_addr: actix_web::web::Data<Addr<DouchatState>>,
    state: actix_web::web::Data<DouchatState>,
    token: DouchatJWTClaims<Access>,
) -> crate::error::Result<HttpResponse> {
    let user = state
        .db()
        .get_user_by_uid(token.uid)?
        .ok_or(DouchatError::unauthorized())?;
    let (addr, resp) = actix_web_actors::ws::WsResponseBuilder::new(
        Session {
            user: user.clone(),
            server_addr: state_addr.get_ref().to_owned(),
        },
        &req,
        stream,
    )
    .start_with_addr()
    .map_err(|e| {
        println!("Error starting websocket route: {:?}", e);
        DouchatError::internal_server_error()
    })?;
    state_addr.get_ref().do_send(Connect { addr, user });
    Ok(resp)
}
