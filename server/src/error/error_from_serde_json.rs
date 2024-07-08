use super::DouchatError;

impl From<serde_json::Error> for DouchatError {
    fn from(value: serde_json::Error) -> Self {
        eprintln!("serde_json error: ");
        eprintln!("{:?}", value);
        DouchatError::internal_server_error()
    }
}
