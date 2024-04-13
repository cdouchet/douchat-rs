use super::DouchatError;
use diesel::result::{DatabaseErrorKind, Error};

impl From<Error> for DouchatError {
    fn from(value: diesel::result::Error) -> Self {
        match value {
            Error::NotFound => Self::not_found(),
            Error::DatabaseError(kind, info) => match kind {
                DatabaseErrorKind::UniqueViolation => {
                    Self::bad_request(info.details().map(|e| e.to_string()))
                }
                DatabaseErrorKind::NotNullViolation => {
                    Self::bad_request(Some(String::from("Check null fields")))
                }
                _ => Self::internal_server_error(),
            },
            _ => Self::internal_server_error(),
        }
    }
}

pub fn from_diesel_error(e: Error) -> DouchatError {
    DouchatError::from(e)
}
