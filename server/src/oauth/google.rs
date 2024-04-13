use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct GoogleSecretInfos {
    client_id: String,
    project_id: String,
    auth_uri: String,
    token_uri: String,
    auth_provider_x509_cert_url: String,
    client_secret: String,
    redirect_uris: Vec<String>,
    javacript_origins: Vec<String>,
}

#[derive(Debug, Deserialize)]
pub struct GoogleSecret {
    web: GoogleSecretInfos,
}

impl GoogleSecret {
    pub fn load() -> Self {
        let cargo_manifest_dir =
            std::env::var("CARGO_MANIFEST_DIR").expect("Could not find CARGO_MANIFEST_DIR env var");
        let google_secret_path = format!("{}/google_secret.json", cargo_manifest_dir);
        let google_secret_file_contents =
            std::fs::read_to_string(google_secret_path).expect("Could not find google_secret.json");
        serde_json::from_str(&google_secret_file_contents)
            .expect("Error reading google_secret.json. It may have an invalid format")
    }
}
