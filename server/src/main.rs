use crate::env::API_PORT;
use accounts::{create_account, get_user_by_uid, get_user_by_username};
use actix::Actor;
use actix_web::{
    web::{self, get, Data},
    App, HttpServer,
};
use dotenvy::dotenv;
use messenger::{
    messenger_routes::{get_user_contacts, get_user_rooms},
    ws,
};
use oauth::{apple::apple_auth, google::google_auth};
use security::jwt::{create_test_user, test_user, test_ws};
use state::DouchatState;

pub mod accounts;
pub mod db;
pub mod env;
pub mod error;
pub mod http;
pub mod messenger;
pub mod oauth;
pub mod schema;
pub mod security;
pub mod state;
pub mod utils;

async fn index() -> String {
    format!(
        "Douchat API v{}",
        std::env::var("CARGO_PKG_VERSION").unwrap()
    )
}

#[actix_web::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenv().ok();
    let state = DouchatState::new();
    create_test_user(state.clone()).expect("Error: could not create test user");
    let state_addr = state.clone().start();
    let app = HttpServer::new(move || {
        App::new()
            .app_data(Data::new(state.clone()))
            .app_data(Data::new(state_addr.clone()))
            .route("/", get().to(index))
            .service(create_account)
            .service(get_user_by_uid)
            .service(get_user_by_username)
            .service(apple_auth)
            .service(google_auth)
            // REMOVE ON PROD
            .service(test_user)
            .service(test_ws)
            .service(ws)
            .service(
                web::scope("/messenger")
                    .service(get_user_rooms)
                    .service(get_user_contacts),
            )
    });

    app.bind(("0.0.0.0", *API_PORT))
        .expect(&format!("Failed to bind port {} to 0.0.0.0", *API_PORT))
        .run()
        .await
        .expect("Fatal: could not start Douchat Server");

    Ok(())
}
