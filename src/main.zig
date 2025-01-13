const std = @import("std");
const rl = @import("raylib");
const player = @import("player.zig");
const keys = @import("keymap.zig");

const HEIGHT = 460;
const WIDTH = 800;

pub fn main() !void {
    rl.initWindow(WIDTH, HEIGHT, "znake");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var snake= player.Player.init(WIDTH/2, HEIGHT/2);
        
    while(!rl.windowShouldClose()) {

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.dark_gray);
        rl.drawText(snake.head, snake.location.x, snake.location.y, snake.size, rl.Color.black);

        const direction =
        if (rl.isKeyPressed(keys.UP)) 
            player.Direction.Up
        else if (rl.isKeyPressed(keys.DOWN))
            player.Direction.Down
         else if (rl.isKeyPressed(keys.LEFT))
            player.Direction.Left
         else if (rl.isKeyPressed(keys.RIGHT)) 
            player.Direction.Right
         else 
            player.Direction.None
        ;

        snake.move(direction);
    }

}
