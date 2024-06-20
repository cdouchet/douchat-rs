use lazy_static::lazy_static;
use std::env::var;

lazy_static! {
    pub static ref CARGO_MANIFEST_DIR: String =
        var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR should be set");
}
