use actix_web::{
    http::{header::ContentType, StatusCode},
    HttpResponseBuilder, ResponseError,
};
use serde::{Deserialize, Serialize};
use std::fmt::Display;

pub mod error_from_diesel;
pub mod error_from_uuid;

pub type Result<T> = std::result::Result<T, DouchatError>;

#[derive(Debug, Serialize, Deserialize)]
pub struct DouchatError {
    #[serde(skip_serializing)]
    #[serde(skip_deserializing)]
    status_code: StatusCode,
    error: String,
    description: Option<String>,
}

impl DouchatError {
    pub fn not_found() -> Self {
        Self {
            status_code: StatusCode::NOT_FOUND,
            error: String::from("Not Found"),
            description: None,
        }
    }

    pub fn internal_server_error() -> Self {
        Self {
            status_code: StatusCode::INTERNAL_SERVER_ERROR,
            error: String::from("Internal Server Error"),
            description: None,
        }
    }

    pub fn bad_request(description: Option<String>) -> Self {
        Self {
            status_code: StatusCode::BAD_REQUEST,
            error: String::from("Bad Request"),
            description,
        }
    }
}

impl Display for DouchatError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", serde_json::to_string(&self).unwrap())
    }
}

impl ResponseError for DouchatError {
    fn status_code(&self) -> actix_web::http::StatusCode {
        self.status_code
    }

    fn error_response(&self) -> actix_web::HttpResponse<actix_web::body::BoxBody> {
        HttpResponseBuilder::new(self.status_code)
            .insert_header(ContentType::json())
            .body(serde_json::to_string(&self).unwrap())
    }
}
