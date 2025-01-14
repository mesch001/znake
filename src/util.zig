pub const HEIGHT = 460;
pub const WIDTH = 800;
pub const BOUND = 10;

pub const UPPER_BOUND = 0 + BOUND;
pub const LOWER_BOUND = HEIGHT - 10;
pub const LEFT_BOUND = 0 + 10;
pub const RIGHT_BOUND = WIDTH - 10;

pub const SIZE = 20;

pub const Point = struct {
    x: i32,
    y: i32,
};

pub fn in_bounds(location: Point) bool {
    return (location.x > LEFT_BOUND) and
        (location.x < (RIGHT_BOUND - BOUND)) and
        (location.y > UPPER_BOUND) and
        (location.y < LOWER_BOUND - BOUND);
}
