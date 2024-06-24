use serde::Deserialize;
use utoipa::{IntoParams, ToSchema};

#[derive(Deserialize, ToSchema, IntoParams)]
pub struct PathId {
    pub id: String,
}

#[derive(Deserialize, ToSchema, IntoParams)]
pub struct PathUsername {
    pub username: String,
}
