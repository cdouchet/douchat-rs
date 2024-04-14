use actix::{Actor, Addr, Handler, StreamHandler};
use actix_web_actors::ws::{self, WebsocketContext};

use crate::{db::models::user::User, error::DouchatError, state::DouchatState};

use super::{
    actions::Disconnect,
    parser::{WebsocketContent, WebsocketContentParser},
};

#[derive(Debug, Clone)]
pub struct Session {
    pub user: User,
    pub server_addr: Addr<DouchatState>,
}

impl Actor for Session {
    type Context = WebsocketContext<Self>;

    fn stopped(&mut self, ctx: &mut Self::Context) {
        self.server_addr.do_send(Disconnect { uid: self.user.uid });
    }
}

impl StreamHandler<Result<ws::Message, ws::ProtocolError>> for Session {
    fn handle(&mut self, item: Result<ws::Message, ws::ProtocolError>, ctx: &mut Self::Context) {
        match item {
            Ok(ws::Message::Text(text)) => {
                let parser = WebsocketContentParser::new(text.to_string());
                let websocket_content = match parser.parse() {
                    Ok(e) => e,
                    Err(err) => {
                        ctx.text(err);
                        return;
                    }
                };
                self.server_addr.do_send(websocket_content);
            }
            Ok(ws::Message::Ping(msg)) => ctx.pong(&msg),
            Ok(ws::Message::Binary(bin)) => ctx.binary(bin),
            _ => {
                ctx.text(
                    serde_json::to_string(&DouchatError::bad_request(Some(String::from(
                        "Invalid Data Format",
                    ))))
                    .unwrap(),
                );
            }
        }
    }

    fn finished(&mut self, ctx: &mut Self::Context) {
        self.server_addr.do_send(Disconnect { uid: self.user.uid });
    }
}

impl Handler<WebsocketContent> for Session {
    type Result = crate::error::Result<()>;

    fn handle(&mut self, msg: WebsocketContent, ctx: &mut Self::Context) -> Self::Result {
        ctx.text(msg);
        Ok(())
    }
}
