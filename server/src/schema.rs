// @generated automatically by Diesel CLI.

diesel::table! {
    contact_requests (id) {
        id -> Int4,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        sender -> Int4,
        receiver -> Int4,
        accepted -> Nullable<Bool>,
    }
}

diesel::table! {
    contacts (user_id, contact_id) {
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        user_id -> Int4,
        contact_id -> Int4,
        request_id -> Int4,
    }
}

diesel::table! {
    message_readings (id) {
        id -> Int8,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        message_id -> Int8,
        reader -> Int4,
    }
}

diesel::table! {
    messages (id) {
        id -> Int8,
        uid -> Uuid,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        sender -> Int4,
        room -> Int4,
        content -> Text,
        message_type -> Varchar,
    }
}

diesel::table! {
    room_users (id) {
        id -> Int4,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        user_id -> Int4,
        room -> Int4,
    }
}

diesel::table! {
    rooms (id) {
        id -> Int4,
        uid -> Uuid,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        name -> Varchar,
        description -> Varchar,
        room_type -> Varchar,
    }
}

diesel::table! {
    users (id) {
        id -> Int4,
        uid -> Uuid,
        created_at -> Timestamptz,
        updated_at -> Timestamptz,
        email -> Varchar,
        username -> Nullable<Varchar>,
        photo_url -> Nullable<Varchar>,
        verification_date -> Nullable<Timestamptz>,
        description -> Nullable<Varchar>,
        status -> Nullable<Varchar>,
        onboarding_completed -> Bool,
    }
}

diesel::joinable!(contacts -> contact_requests (request_id));
diesel::joinable!(message_readings -> messages (message_id));
diesel::joinable!(message_readings -> users (reader));
diesel::joinable!(messages -> rooms (room));
diesel::joinable!(messages -> users (sender));
diesel::joinable!(room_users -> rooms (room));
diesel::joinable!(room_users -> users (user_id));

diesel::allow_tables_to_appear_in_same_query!(
    contact_requests,
    contacts,
    message_readings,
    messages,
    room_users,
    rooms,
    users,
);
