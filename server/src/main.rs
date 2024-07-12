#![allow(dead_code)]

use crate::env::API_PORT;
use accounts::{
    deep_link::{apple_app_site_association, asset_links_json},
    devices_routes::{append_device, append_notification_token, get_user_devices},
    get_user_by_uid, get_user_by_username, me,
    onboarding_routes::{complete_onboarding, update_username, upload_user_picture},
};
use actix::Actor;
use actix_web::{
    get,
    middleware::Logger,
    web::{self, get, Data},
    App, HttpServer,
};
use cdn::picture::get_user_picture;
use documentation::ApiDoc;
use dotenvy::dotenv;
use error::DouchatError;
use fcm::Error;
use http::HTTP_CLIENT;
use messenger::{
    messenger_routes::{get_user_contacts, get_user_rooms},
    ws,
};
use oauth::{apple::apple_auth, google::google_auth};
use oauth_fcm::{send_fcm_message, FcmError, FcmNotification, NetworkError};
use security::jwt::{create_test_user_and_device, refresh_access_token, test_user, test_ws};
use serde_json::json;
use state::DouchatState;
use utils::rust_vars::CARGO_MANIFEST_DIR;
use utoipa_swagger_ui::SwaggerUi;

pub mod accounts;
pub mod cdn;
pub mod db;
pub mod documentation;
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

#[get("/test_notif")]
async fn test_send_notif(state: Data<DouchatState>) -> crate::error::Result<String> {
    let device_token = "fCyAoJFiCU2-ub7hy_nXSJ:APA91bFXueHPj5crKnpeOtu-xF64QMJMAlDERJsdPgxz-uXHvhbGwyZoIvqffNQ0V4loArbTwcPieEAP6NwexII5zQgKSuuDXHuDfcacR0oMMgIa-wB8ChdjiUEoF63EUXNMh4jzVbWB";
    let notification = Some(FcmNotification {
        title: String::from("Test notiiiif"),
        body: String::from("HELOOOOO"),
    });
    let payload = json!({
        "title": "Test title",
        "message": "Heloooooooo",
        "avatar": "https://douchat-api.doggo-saloon.net/user/picture/5ba80ac1-5ae5-47d9-96a0-99db6972568d.jpg",
        "sender_nickname": "Zyril",
        "sender_uuid": "5ba80ac1-5ae5-47d9-96a0-99db6972568d"
    });

    let collapse_id = "93823923809283293890203";

    let mut token_manager_guard = state.token_manager().lock().await;
    let access_token = token_manager_guard.get_token().await?;

    let fcm_payload = json!({
        "message": {
            "token": device_token,
            "notification": {
                "title": "Test title",
                "body": "Hellooooooo",
            },
            "apns": {
                "headers": {
                    // "apns-priority": "5",
                    // "apns-collapse-id": collapse_id,
                },
                "payload": {
                    "aps": {
                        "alert": {
                            "title": "Test title",
                            "body": "J'aime bien tout ça",
                        },
                        "mutable-content": 1
                    }
                },
            },
            "data": {
                "title": "Test title",
                "message": "HelooooooMessageeee",
                "avatar": "https://douchat-api.doggo-saloon.net/user/picture/5ba80ac1-5ae5-47d9-96a0-99db6972568d.jpg",
                "sender_nickname": "Zyril",
                "sender_uuid": "5ba80ac1-5ae5-47d9-96a0-99db6972568d",
                "room_id": "5ba80ac1-5ae5-47d9-96a0-99db6972568d",
            }
        }
    });

    let url = "https://fcm.googleapis.com/v1/projects/douchatrs/messages:send";

    let res = HTTP_CLIENT
        .post(url)
        .bearer_auth(access_token)
        .json(&fcm_payload)
        .send()
        .await;
    if let Err(err) = res {
        return Ok(format!("FAILURE: {}", &err));
    }
    Ok(String::from("OK"))
}

#[actix_web::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenv().ok();
    let state = DouchatState::new();
    create_test_user_and_device(state.clone()).expect("Error: could not create test user");
    let state_addr = state.clone().start();
    let app = HttpServer::new(move || {
        App::new()
            .wrap(Logger::default())
            .app_data(Data::new(state.clone()))
            .app_data(Data::new(state_addr.clone()))
            .route("/", get().to(index))
            .service(get_user_by_uid)
            .service(get_user_by_username)
            .service(me)
            .service(complete_onboarding)
            .service(apple_auth)
            .service(google_auth)
            .service(test_ws)
            .service(ws)
            .service(web::scope("/security").service(refresh_access_token))
            .service(
                web::scope("/messenger")
                    .service(get_user_rooms)
                    .service(get_user_contacts),
            )
            // Deep link
            .service(apple_app_site_association)
            .service(asset_links_json)
            // Devices
            .service(append_device)
            .service(get_user_devices)
            .service(append_notification_token)
            // Cdn
            .service(get_user_picture)
            // Onboarding
            .service(update_username)
            .service(upload_user_picture)
            // Test User TODO: TO REMOVE
            .service(test_user)
            .service(test_send_notif)
            .service(SwaggerUi::new("/docs/{_:.*}").url("/api-docs/openapi.json", ApiDoc::create()))
    });

    app.bind(("0.0.0.0", *API_PORT))
        .expect(&format!("Failed to bind port {} to 0.0.0.0", *API_PORT))
        .run()
        .await
        .expect("Fatal: could not start Douchat Server");

    Ok(())
}
