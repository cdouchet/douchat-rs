use actix_web::{
    get, http::{
        header::HeaderValue,
        StatusCode,
    }, HttpResponse, HttpResponseBuilder
};

use crate::utils::rust_vars::CARGO_MANIFEST_DIR;

#[get("/apple-app-site-association")]
pub async fn apple_app_site_association() -> HttpResponse {
    let path = format!("{}/apple-app-site-association", CARGO_MANIFEST_DIR.as_str());
    HttpResponseBuilder::new(StatusCode::OK)
        .content_type(HeaderValue::from_str("application/json; charset=utf-8").unwrap())
        .body(std::fs::read_to_string(path).unwrap())
}

#[get("/.well-known/assetlinks.json")]
pub async fn asset_links_json() -> String {
    let path = format!("{}/assetlinks.json", CARGO_MANIFEST_DIR.as_str());
    std::fs::read_to_string(path).unwrap()
}
