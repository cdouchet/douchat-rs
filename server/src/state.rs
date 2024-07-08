use crate::{
    db::DouchatPool,
    messenger::{notification_service::NotificationService, Messenger},
};

#[derive(Debug, Clone)]
pub struct DouchatState {
    pool: DouchatPool,
    messenger: Messenger,
    notifications: NotificationService,
}

impl DouchatState {
    pub fn new() -> Self {
        Self {
            pool: DouchatPool::new(),
            messenger: Messenger::new(),
            notifications: NotificationService::new(),
        }
    }

    pub fn db(&self) -> &DouchatPool {
        &self.pool
    }

    pub fn messenger(&self) -> &Messenger {
        &self.messenger
    }

    pub fn notifications(&self) -> &NotificationService {
        &self.notifications
    }

    pub fn messenger_mut(&mut self) -> &mut Messenger {
        &mut self.messenger
    }
}
