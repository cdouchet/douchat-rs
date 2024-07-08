use fcm::FcmError;

use super::DouchatError;

impl From<FcmError> for DouchatError {
    fn from(value: FcmError) -> Self {
        match value {
            FcmError::Unauthorized => {
                eprintln!("Could not send an fcm message, credentials for fcm might be invalid. The error was:");
                eprintln!("{:?}", value);
            }
            FcmError::InvalidMessage(reason) => {
                eprintln!("Invalid Fcm message sent:");
                eprintln!("{reason}");
            }
            FcmError::ServerError(retry_opt) => {
                eprintln!("Something went wrong with FCM:");
                eprintln!("{:?}", retry_opt);
            }
        }
        DouchatError::internal_server_error()
    }
}
