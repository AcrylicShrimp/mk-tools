use component_macros::*;
use mk::{run, EngineError};
use std::env::current_dir;

#[derive(Component)]
pub struct Layer(
    #[animate(ty = "integer", name = "value1")] u64,
    #[animate(ty = "float", name = "value2")] f32,
);

#[derive(Component)]
pub struct Struct {
    #[animate(ty = "integer", name = "position.x")]
    pub x: f32,
    #[animate(ty = "float", name = "position.y")]
    pub y: f32,
    #[animate(ty = "float", name = "position.z")]
    pub z: f32,
}

fn main() -> Result<(), EngineError> {
    run(
        "test",
        640,
        480,
        current_dir()?.join("assets"),
        "scripts/entry.lua",
    )
}
