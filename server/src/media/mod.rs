use std::{io::Read, iter::once, str::FromStr};

use actix_files::NamedFile;
use actix_web::{
    get,
    http::header::{HeaderName, HeaderValue},
    HttpRequest, HttpResponse,
};
use async_stream::try_stream;
use rand::{thread_rng, Rng};

use crate::{error::Result, utils::rust_vars::CARGO_MANIFEST_DIR};

#[get("/login/background")]
pub async fn get_login_background(req: HttpRequest) -> Result<NamedFile> {
    let random = thread_rng().gen_range(1..4);
    let path = format!("{}/assets/{}.mp4", CARGO_MANIFEST_DIR.as_str(), random);
    // let file = std::fs::File::open(path).unwrap();
    // let bytes = file.bytes();
    // let file = NamedFile::open(path).unwrap();

    // let stream = try_stream! {
    //     let mut f = fs::File:
    // };

    // Ok(HttpResponse::Ok().streaming(file))

    // Ok(HttpResponse::Ok().streaming(actix_web::web::Bytes::copy_from_slice(bytes).bytes()))
    // let file = actix_files::NamedFile::open_async(path).await.unwrap();
    // let mut resp = file.into_response(&req);
    // resp.headers_mut().append(
    //     HeaderName::from_str("Cache-Control").unwrap(),
    //     HeaderValue::from_str("no-cache, no-store, must-revalidate").unwrap(),
    // );

    // Ok(resp)

    let file = actix_files::NamedFile::open(path).unwrap();
    Ok(file.use_last_modified(true))
}
