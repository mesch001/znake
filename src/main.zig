const std = @import("std");
const rl = @import("raylib");
const player = @import("player.zig");
const keys = @import("keymap.zig");
const bounds = @import("util.zig");
const foods = @import("food.zig");

pub fn main() !void {
    rl.initWindow(bounds.WIDTH, bounds.HEIGHT, "znake");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var snake = player.Player.init();
    var food = foods.Food.generate();

    while (true) {
        var reset = false;
        while (!reset) {
            if (rl.windowShouldClose()) {
                return;
            }
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.dark_gray);
            draw_bounds();

            rl.drawText(snake.head, snake.location.x, snake.location.y, bounds.SIZE, rl.Color.black);
            rl.drawText(food.symbol, food.location.x, food.location.y, bounds.SIZE, rl.Color.black);

            if (rl.isKeyPressed(keys.UP))
                snake.change_direction(player.Direction.Up);
            if (rl.isKeyPressed(keys.DOWN))
                snake.change_direction(player.Direction.Down);
            if (rl.isKeyPressed(keys.LEFT))
                snake.change_direction(player.Direction.Left);
            if (rl.isKeyPressed(keys.RIGHT))
                snake.change_direction(player.Direction.Right);

            reset = snake.move();

            if (snake.has_eaten(food.location)) {
                std.debug.print("Food eaten\n", .{});
                food = foods.Food.generate();
            }
        }
        std.debug.print("Hit obstacle. Restarting game", .{});
        snake = player.Player.init();
    }
}

fn draw_bounds() void {
    // Top Boundary
    rl.drawRectangle(0, 0, bounds.WIDTH, bounds.BOUND, rl.Color.black);
    // Left Boundary
    rl.drawRectangle(0, 0, bounds.BOUND, bounds.HEIGHT, rl.Color.black);
    // Right Boundary
    rl.drawRectangle(bounds.RIGHT_BOUND, 0, bounds.BOUND, bounds.HEIGHT, rl.Color.black);
    // Lower Boundary
    rl.drawRectangle(0, bounds.LOWER_BOUND, bounds.WIDTH, bounds.BOUND, rl.Color.black);
}
