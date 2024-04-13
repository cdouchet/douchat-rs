use accounts::{create_account, get_user_by_uid, get_user_by_username};
use actix_web::{
    web::{get, Data},
    App, HttpServer,
};
use dotenvy::dotenv;
use state::DouchatState;
use utils::env::API_PORT;

pub mod accounts;
pub mod db;
pub mod error;
pub mod schema;
pub mod state;

async fn index() -> String {
    format!(
        "Douchat API v{}",
        std::env::var("CARGO_PKG_VERSION").unwrap()
    )
}

#[actix_web::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenv().ok();
    let app = HttpServer::new(|| {
        App::new()
            .app_data(Data::new(DouchatState::new()))
            .route("/", get().to(index))
            .service(create_account)
            .service(get_user_by_uid)
            .service(get_user_by_username)
    });

    app.bind(("0.0.0.0", *API_PORT))
        .expect(&format!("Failed to bind port {} to 0.0.0.0", *API_PORT))
        .run()
        .await
        .expect("Fatal: could not start Douchat Server");

    Ok(())
}
