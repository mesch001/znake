use crate::food::Food;
use crate::util::{HEIGHT, MOVEMENT, WIDTH};
use raylib::core::math::Vector2;
use std::collections::VecDeque;

const PLAYER_SIZE: i32 = 10;

#[derive(PartialEq, Debug)]
pub enum Direction {
    Up,
    Down,
    Left,
    Right,
}

pub struct Player {
    head: Vector2,
    direction: Direction,
    pub tails: VecDeque<Vector2>,
    add_tail: bool,
    points: u32,
}

impl Player {
    pub fn new() -> Self {
        Self {
            head: Vector2::new((WIDTH / 2) as f32, (HEIGHT / 2) as f32),
            direction: Direction::Right,
            tails: VecDeque::new(),
            add_tail: false,
            points: 0,
        }
    }
    pub fn reset(&mut self) {
        self.head = Vector2::new((WIDTH / 2) as f32, (HEIGHT / 2) as f32);
        self.direction = Direction::Right;
        self.tails.clear();
        self.points = 0;
    }

    pub fn x(&self) -> i32 {
        self.head.x as i32
    }
    pub fn y(&self) -> i32 {
        self.head.y as i32
    }
    #[inline]
    pub fn size() -> i32 {
        PLAYER_SIZE
    }

    pub fn points(&self) -> u32 {
        self.points
    }

    pub fn add_tail(&mut self) {
        self.add_tail = true;
    }

    pub fn change_direction(&mut self, direction: Direction) {
        self.direction = direction;
    }

    pub fn player_move(&mut self) -> bool {
        let movement = MOVEMENT as f32;

        let new_location = match self.direction {
            Direction::Up => Vector2::new(self.head.x, self.head.y - movement),
            Direction::Down => Vector2::new(self.head.x, self.head.y + movement),
            Direction::Left => Vector2::new(self.head.x - movement, self.head.y),
            Direction::Right => Vector2::new(self.head.x + movement, self.head.y),
        };

        if crate::util::in_bounds(new_location) {
            if self.add_tail {
                self.points += 1;
                self.tails.push_back(self.head);
                self.add_tail = false;
            }

            if self.tails.pop_back().is_some() {
                self.tails.push_front(self.head);
            };

            self.head = new_location;
            for tail in &self.tails {
                if self.head == *tail {
                    println!("Head: {:?}, Tail: {:?}", self.head, tail);
                    return false;
                }
            }

            true
        } else {
            false
        }
    }

    pub fn has_eaten(&self, eatable: &Food) -> bool {
        let dx: f32 = ((eatable.x() - self.x()).abs() - Player::size() / 2) as f32;
        let dy: f32 = ((eatable.y() - self.y()).abs() - Player::size() / 2) as f32;

        if dx > Food::size() as f32 || dy > Food::size() as f32 {
            return false;
        };
        if dx <= 0. || dy <= 0. {
            return true;
        };

        dx * dx + dy * dy < (Food::size() * Food::size()) as f32
    }
}
