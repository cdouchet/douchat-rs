use actix_web::http::StatusCode;
use uuid::Error;

use super::DouchatError;

impl From<Error> for DouchatError {
    fn from(_: Error) -> Self {
        Self {
            status_code: StatusCode::BAD_REQUEST,
            error: String::from("Invalid uuid"),
            description: None,
        }
    }
}

pub fn from_uuid_error(e: Error) -> DouchatError {
    DouchatError::from(e)
}
