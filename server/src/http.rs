use lazy_static::lazy_static;
use reqwest::Client;

lazy_static! {
    pub static ref HTTP_CLIENT: Client = Client::builder()
        .gzip(true)
        .deflate(true)
        .build()
        .expect("Error building reqwest http client");
}
