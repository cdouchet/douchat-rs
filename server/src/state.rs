use oauth_fcm::{create_shared_token_manager, SharedTokenManager};

use crate::{
    db::DouchatPool,
    messenger::{notification_service::NotificationService, Messenger},
    utils::rust_vars::CARGO_MANIFEST_DIR,
};

#[derive(Clone)]
pub struct DouchatState {
    pool: DouchatPool,
    messenger: Messenger,
    notifications: NotificationService,
    token_manager: SharedTokenManager,
}

impl DouchatState {
    pub fn new() -> Self {
        Self {
            pool: DouchatPool::new(),
            messenger: Messenger::new(),
            notifications: NotificationService::new(),
            token_manager: create_shared_token_manager(&format!(
                "{}/firebase-credentials.json",
                CARGO_MANIFEST_DIR.as_str()
            ))
            .expect("firebase-credentials.json is surely missing"),
        }
    }

    pub fn db(&self) -> &DouchatPool {
        &self.pool
    }

    pub fn messenger(&self) -> &Messenger {
        &self.messenger
    }

    pub fn messenger_mut(&mut self) -> &mut Messenger {
        &mut self.messenger
    }

    pub fn notifications(&self) -> &NotificationService {
        &self.notifications
    }

    pub fn token_manager(&self) -> &SharedTokenManager {
        &self.token_manager
    }
}
