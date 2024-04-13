use diesel::{
    r2d2::{ConnectionManager, PooledConnection},
    PgConnection,
};

pub mod models;

type Pool = diesel::r2d2::Pool<ConnectionManager<PgConnection>>;

fn create_pool() -> Pool {
    let manager = ConnectionManager::<PgConnection>::new(utils::env::DATABASE_URL.to_string());
    diesel::r2d2::Pool::builder()
        .max_size(5)
        .build(manager)
        .expect("Error creating pool")
}

#[derive(Debug, Clone)]
pub struct DouchatPool {
    pool: Pool,
}

impl DouchatPool {
    pub fn new() -> Self {
        Self {
            pool: create_pool(),
        }
    }

    pub fn get_conn(&self) -> PooledConnection<ConnectionManager<PgConnection>> {
        self.pool.get().unwrap()
    }
}
