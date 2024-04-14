use super::session::Session;

#[derive(Debug, Clone)]
pub struct Room {
    users: Vec<Session>,
}

impl Room {
    pub fn new() -> Self {
        Self { users: Vec::new() }
    }
}
