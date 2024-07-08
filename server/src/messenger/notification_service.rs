use fcm::Client;
use serde::Serialize;
use std::fmt::Debug;

use crate::{env::FIREBASE_API_KEY, error::DouchatError};

pub struct NotificationService {
    fcm: Client,
}

impl Clone for NotificationService {
    fn clone(&self) -> Self {
        let client = Client::new();
        Self { fcm: client }
    }
}

impl Debug for NotificationService {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:?}", self)
    }
}

#[derive(Serialize)]
pub struct DouchatNotificationPayload<'a> {
    pub title: &'a str,
    pub message: &'a str,
    pub avatar: &'a str,
    pub sender_nickname: &'a str,
    pub sender_uuid: &'a str,
}

impl NotificationService {
    pub fn new() -> Self {
        Self { fcm: Client::new() }
    }

    pub async fn send_notification<'a>(
        &self,
        receiver_fcm_token: &'a str,
        payload: DouchatNotificationPayload<'a>,
    ) -> Result<(), DouchatError> {
        let mut message_builder = fcm::MessageBuilder::new(&FIREBASE_API_KEY, receiver_fcm_token);
        let mut notification_builder = fcm::NotificationBuilder::new();
        notification_builder.title(&payload.title);
        notification_builder.body(&payload.message);
        message_builder.data(&payload)?;

        let notification = notification_builder.finalize();
        message_builder.notification(notification);

        let message = message_builder.finalize();

        self.fcm.send(message).await?;

        Ok(())
    }
}
