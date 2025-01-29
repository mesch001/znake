use crate::Vector2;

pub const SIZE: i32 = 10;
pub const WIDTH: i32 = 800;
pub const HEIGHT: i32 = 600;

pub const MOVEMENT: i32 = 5;

pub const UPPER_BOUND: i32 = 2 * SIZE;
pub const LOWER_BOUND: i32 = HEIGHT - SIZE;
pub const LEFT_BOUND: i32 = SIZE;
pub const RIGHT_BOUND: i32 = WIDTH - SIZE;

pub fn in_bounds(location: Vector2) -> bool {
    (location.x > LEFT_BOUND as f32)
        && (location.x < (RIGHT_BOUND - SIZE) as f32)
        && (location.y > UPPER_BOUND as f32)
        && (location.y < (LOWER_BOUND - SIZE) as f32)
}
