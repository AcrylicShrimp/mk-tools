use mk::{run, EngineError};
use std::env::current_dir;

fn main() -> Result<(), EngineError> {
    run(
        "test",
        640,
        480,
        current_dir()?.join("assets"),
        "scripts/entry.lua",
    )
}
