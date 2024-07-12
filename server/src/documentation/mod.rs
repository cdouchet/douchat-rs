use utoipa::{openapi::ServerBuilder, OpenApi};

use self::paths::{PathId, PathUsername};
use crate::accounts::{
    __path_get_user_by_uid, __path_get_user_by_username, __path_me,
    devices_routes::{
        AppendNotificationTokenForm, AppendUserDeviceForm, __path_append_device,
        __path_append_notification_token, __path_get_user_devices,
    },
    onboarding_routes::{
        UsernameUpdateForm, __path_complete_onboarding, __path_update_username,
        __path_upload_user_picture,
    },
};
use crate::cdn::picture::{QueryUid, __path_get_user_picture};
use crate::db::models::{
    user::{NewUser, User},
    user_device::UserDevice,
    user_picture::{UserPicture, UserPictureMultipart},
};
use crate::error::DouchatError;
use crate::oauth::{
    apple::{AppleName, AppleOauthPayload, AppleUser, __path_apple_auth},
    google::{GoogleOAuthPayload, __path_google_auth},
};
use crate::security::{
    jwt::__path_refresh_access_token,
    user_info_jwt::{
        UserInfo, UserInfoJWTClaims, __path_get_info_from_user_info_token,
        __path_get_user_info_token,
    },
};

use crate::env::API_BASE_URL;

pub mod paths;

#[derive(OpenApi)]
#[openapi(
    info(
        title = "Douchat API"
    ),
    tags(
        (name = "OAuth", description = "OAuth focused authentication"),
        (name = "Login", description = "Traditional ways to authenticate"),
        (name = "Accounts", description = "Accounts"),
        (name = "Onboarding", description = "Onboarding"),
        (name = "Devices", description = "Update and modify user devices"),
        (name = "Cdn", description = "Media routes")
    ),
    components(
        schemas(
            User,
            UserInfo,
            UserInfoJWTClaims,
            NewUser,
            AppleOauthPayload,
            AppleUser,
            AppleName,
            GoogleOAuthPayload,
            PathId,
            PathUsername,
            AppendNotificationTokenForm,
            UserDevice,
            UserPicture,
            UserPictureMultipart,
            QueryUid,
            AppendUserDeviceForm,
            UsernameUpdateForm,
            DouchatError
        )
    ),
    paths(
        // Devices
        append_device,
        append_notification_token,
        get_user_devices,
        // Onboarding
        update_username,
        upload_user_picture,
        complete_onboarding,
        // OAuth
        apple_auth,
        google_auth,
        // Login
        refresh_access_token,
        // Cdn
        get_user_picture,
        // Accounts
        get_user_by_uid,
        get_user_by_username,
        me,
        get_user_info_token,
        get_info_from_user_info_token,
    )
)]
pub struct ApiDoc;

impl ApiDoc {
    pub fn create() -> utoipa::openapi::OpenApi {
        let mut doc = Self::openapi();
        let server = ServerBuilder::new().url(API_BASE_URL.to_string()).build();
        doc.servers = Some(vec![server]);
        doc
    }
}
