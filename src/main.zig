const std = @import("std");
const rl = @import("raylib");
const player = @import("player.zig");
const keys = @import("keymap.zig");
const util = @import("util.zig");
const foods = @import("food.zig");
const unicode = std.unicode;

const POINTS = "Points: ";

pub fn main() !void {
    rl.initWindow(util.WIDTH, util.HEIGHT, "znake");
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

            rl.drawText(util.SNAKE_HEAD, snake.location.x, snake.location.y, util.SPRITE_SIZE, rl.Color.black);
            rl.drawText(util.FOOD, food.location.x, food.location.y, util.SPRITE_SIZE, rl.Color.black);
            var b: [13:0] u8 = undefined;
            @memset(&b, ' ');
            const points: [*:0]const u8 = @ptrCast(std.fmt.bufPrint(&b, "Points: {d}", .{snake.points}) catch undefined);
            rl.drawText(points, util.SCOREBOARD_X, util.SCOREBOARD_Y, util.SPRITE_SIZE, rl.Color.black);

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
                food = foods.Food.generate();
            }
        }
        std.debug.print("Hit obstacle. Restarting game", .{});
        snake = player.Player.init();
    }
}

fn draw_bounds() void {
    // Top Boundary
    rl.drawRectangle(0, 0, util.WIDTH, util.BOUND, rl.Color.black);
    // Left Boundary
    rl.drawRectangle(0, 0, util.BOUND, util.HEIGHT, rl.Color.black);
    // Right Boundary
    rl.drawRectangle(util.RIGHT_BOUND, 0, util.BOUND, util.HEIGHT, rl.Color.black);
    // Lower Boundary
    rl.drawRectangle(0, util.LOWER_BOUND, util.WIDTH, util.BOUND, rl.Color.black);
}
