use raylib::prelude::*;

mod food;
mod player;
mod util;

use food::Food;
use player::{Direction, Player};
use util::{HEIGHT, SIZE, WIDTH};

fn main() {
    let (mut rl, thread) = raylib::init().size(WIDTH, HEIGHT).title("rsnake").build();
    rl.set_target_fps(60);

    let mut player = Player::new();
    let mut food = Food::new();

    while !rl.window_should_close() {
        move_player(&mut rl, &mut player);
        draw(&mut rl, &thread, &mut player, &food);

        if player.has_eaten(&food) {
            food.reset();
            player.add_tail();
        };
    }
}

fn draw(rl: &mut RaylibHandle, thread: &RaylibThread, player: &mut Player, food: &Food) {
    let mut d = rl.begin_drawing(thread);

    d.clear_background(Color::LIGHTGRAY);
    let points = format!("Points: {}", player.points());
    d.draw_text(&points, 0, 0, SIZE, Color::BLACK);
    d.draw_rectangle(
        player.x(),
        player.y(),
        Player::size(),
        Player::size(),
        Color::BLACK,
    );
    for tail in &player.tails {
        d.draw_rectangle(
            tail.x as i32,
            tail.y as i32,
            Player::size(),
            Player::size(),
            Color::BLACK,
        );
    }
    d.draw_rectangle(0, SIZE, WIDTH, SIZE, Color::BLACK);
    d.draw_rectangle(0, SIZE, SIZE, HEIGHT, Color::BLACK);
    d.draw_rectangle(0, HEIGHT - SIZE, WIDTH, HEIGHT, Color::BLACK);
    d.draw_rectangle(WIDTH - SIZE, SIZE, HEIGHT, HEIGHT, Color::BLACK);
    d.draw_circle(food.x(), food.y(), Food::size() as f32, Color::BLACK);
}

fn move_player(rl: &mut RaylibHandle, player: &mut Player) {
    if rl.is_key_pressed(KeyboardKey::KEY_W) {
        player.change_direction(Direction::Up);
    } else if rl.is_key_pressed(KeyboardKey::KEY_S) {
        player.change_direction(Direction::Down);
    } else if rl.is_key_pressed(KeyboardKey::KEY_A) {
        player.change_direction(Direction::Left);
    } else if rl.is_key_pressed(KeyboardKey::KEY_D) {
        player.change_direction(Direction::Right);
    };

    if !player.player_move() {
        player.reset();
    }
}
