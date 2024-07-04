use crate::env::DEBUG_MODE;

use super::DouchatError;
use diesel::result::{DatabaseErrorKind, Error};

impl From<Error> for DouchatError {
    fn from(value: diesel::result::Error) -> Self {
        if *DEBUG_MODE {
            eprintln!("DIESEL ERROR: {:?}", value);
        }
        match value {
            Error::NotFound => Self::not_found(Some(value.to_string())),
            Error::DatabaseError(kind, info) => match kind {
                DatabaseErrorKind::UniqueViolation => {
                    Self::bad_request(info.details().map(|e| e.to_string()))
                }
                DatabaseErrorKind::NotNullViolation => {
                    Self::bad_request(Some(String::from("Check null fields")))
                }
                DatabaseErrorKind::ForeignKeyViolation => Self::bad_request(Some(String::from(
                    info.details().unwrap_or("ForeignKeyViolation"),
                ))),
                _ => Self::internal_server_error(),
            },
            _ => Self::internal_server_error(),
        }
    }
}

pub fn from_diesel_error(e: Error) -> DouchatError {
    DouchatError::from(e)
}
