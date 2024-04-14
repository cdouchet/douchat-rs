use crate::{db::DouchatPool, messenger::Messenger};

#[derive(Debug, Clone)]
pub struct DouchatState {
    pool: DouchatPool,
    messenger: Messenger,
}

impl DouchatState {
    pub fn new() -> Self {
        Self {
            pool: DouchatPool::new(),
            messenger: Messenger::new(),
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
}
