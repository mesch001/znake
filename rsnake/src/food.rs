use crate::util::{LEFT_BOUND, LOWER_BOUND, RIGHT_BOUND, SIZE, UPPER_BOUND};
use rand::Rng;
use raylib::core::math::Vector2;

const FOOD_SIZE: i32 = 5;

pub struct Food {
    position: Vector2,
}

impl Food {
    pub fn new() -> Self {
        let position = position();
        Self { position }
    }

    pub fn reset(&mut self) {
        self.position = position();
    }

    pub fn x(&self) -> i32 {
        self.position.x as i32
    }
    pub fn y(&self) -> i32 {
        self.position.y as i32
    }
    pub fn size() -> i32 {
        FOOD_SIZE
    }
}

fn position() -> Vector2 {
    let mut rng = rand::rng();

    // Leave some more room when creating the food item.
    // Otherwise it will be really hard to catch
    let left = LEFT_BOUND + SIZE;
    let right = RIGHT_BOUND - SIZE;
    let upper = UPPER_BOUND + SIZE;
    let lower = LOWER_BOUND - SIZE;
    let x = rng.random_range(left..right) as f32;
    let y = rng.random_range(upper..lower) as f32;

    Vector2::new(x, y)
}
