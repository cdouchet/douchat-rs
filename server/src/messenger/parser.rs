use actix::Message;
use bytestring::ByteString;
use serde::{Deserialize, Serialize};

use crate::error::{DouchatError, Result};

pub struct WebsocketContentParser(String);

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct TestMessage {
    content: String,
}

#[derive(Debug, Serialize, Deserialize, Message, Clone)]
#[rtype(result = "Result<()>")]
#[serde(rename_all = "lowercase")]
pub enum WebsocketContent {
    SendMessage(TestMessage),
}

impl WebsocketContentParser {
    pub fn new(content: String) -> Self {
        Self(content)
    }

    pub fn parse(self) -> Result<WebsocketContent> {
        serde_json::from_str::<WebsocketContent>(&self.0)
            .map_err(|_| DouchatError::bad_request(Some(String::from("Invalid JSON input. Either your JSON is malformed, or the given json could not be interpreted"))))
    }
}

impl Into<ByteString> for WebsocketContent {
    fn into(self) -> ByteString {
        serde_json::to_string(&self).unwrap().into()
    }
}
