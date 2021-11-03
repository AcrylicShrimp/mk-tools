use component_macros::*;
use mk::{run, EngineError};
use std::env::current_dir;

pub trait Component {
    fn ty(&self) -> &'static str;
    fn animate(
        &mut self,
        _time_line: &mk::animation::AnimationTimeLine,
        _key_frame: &mk::animation::AnimationKeyFrame,
        _normalized_time_in_key_frame: f32,
    ) {
    }
}

#[derive(Component)]
pub struct Layer(
    #[animate(field = "value1", ty = "integer")] u64,
    #[animate(field = "value2", ty = "float")] f32,
);

#[derive(Component)]
pub struct Struct {
    #[animate(field = "position.x", ty = "integer")]
    pub x: f32,
    #[animate(field = "position.y", ty = "float")]
    pub y: f32,
    #[animate(field = "position.z", ty = "float")]
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
