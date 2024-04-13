use crate::db::DouchatPool;

#[derive(Debug, Clone)]
pub struct DouchatState {
    pool: DouchatPool,
}

impl DouchatState {
    pub fn new() -> Self {
        Self {
            pool: DouchatPool::new(),
        }
    }

    pub fn db(&self) -> &DouchatPool {
        &self.pool
    }
}
