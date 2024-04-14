// @generated automatically by Diesel CLI.

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
    }
}
