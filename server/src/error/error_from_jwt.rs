use jsonwebtoken::errors::Error;

use super::DouchatError;

impl From<Error> for DouchatError {
    fn from(_: Error) -> Self {
        Self::internal_server_error()
    }
}

pub fn from_jwt_error(e: Error) -> DouchatError {
    DouchatError::from(e)
}
