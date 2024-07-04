use actix_web::{
    get, put,
    web::{Data, Json},
};
use serde::Deserialize;
use utoipa::ToSchema;

use crate::{
    db::models::{
        user_device::{NewUserDevice, UserDevice},
        user_notification_token::NewUserNotificationToken,
    },
    error::Result,
    security::jwt::{Access, DouchatJWTClaims},
    state::DouchatState,
};

#[derive(Deserialize, ToSchema)]
pub struct AppendUserDeviceForm {
    device_id: String,
    device_name: String,
}

/// Append Device
#[utoipa::path(
    put,
    path = "/user/devices",
    tag = "Devices",
    request_body = AppendUserDeviceForm,
    responses(
        (status = 200, description = "Successfully appended device", body = UserDevice),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[put("/user/devices")]
pub async fn append_device(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
    Json(body): Json<AppendUserDeviceForm>,
) -> Result<Json<UserDevice>> {
    state
        .db()
        .insert_device(NewUserDevice {
            device_id: body.device_id,
            device_name: body.device_name,
            user_id: claims.id,
        })
        .map(|e| Json(e))
}

/// Get Devices
#[utoipa::path(
    get,
    path = "/user/devices",
    tag = "Devices",
    responses(
        (status = 200, description = "Successfully fetched user registered devices", body = Vec<UserDevice>),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError)
    )
)]
#[get("/user/devices")]
pub async fn get_user_devices(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
) -> Result<Json<Vec<UserDevice>>> {
    Ok(Json(state.db().get_user_devices(claims.id).map(|e| e.0)?))
}

#[derive(Deserialize, ToSchema)]
pub struct AppendNotificationTokenForm {
    device_id: i64,
    token: String,
}

/// Send Notification Token
#[utoipa::path(
    put,
    path = "/user/devices/token",
    tag = "Devices",
    request_body = AppendNotificationTokenForm,
    responses(
        (status = 200, description = "Successfully upserted device notification token", body = String),
        (status = 401, description = "Unauthorized", body = DouchatError),
        (status = 500, description = "Internal Server Error", body = DouchatError),
    )
)]
#[put("/user/devices/token")]
pub async fn append_notification_token(
    state: Data<DouchatState>,
    claims: DouchatJWTClaims<Access>,
    Json(body): Json<AppendNotificationTokenForm>,
) -> Result<String> {
    state
        .db()
        .insert_user_notification_token(NewUserNotificationToken {
            device_id: body.device_id,
            token: body.token,
            user_id: claims.id,
        })?;
    Ok(String::from("OK"))
}
