const print = @import("std").debug.print;
pub const Direction = enum {
    Up,
    Down,
    Left,
    Right,
    None,
};

const Point = struct {
    x: i32,
    y: i32,
};

pub const Player = struct {
    location: Point,
    direction: Direction,
    size: i32,
    head: [*:0]const u8,

    pub fn init(x: i32, y: i32) Player {
        const location: Point = .{
            .x = x,
            .y = y,
        };

       return Player {
            .location = location,
            .direction = Direction.None,
            .size = 20,
            .head = "="
        };
    }

    pub fn move(self: *Player, direction: Direction) void {
        var new_location = self.location;

        switch (direction) {
            Direction.Up =>{ 
                self.direction = direction;
                new_location.y -= @divFloor(self.size, 2);
            },
            Direction.Down => {
                self.direction = direction;
                new_location.y += @divFloor(self.size, 2);
            },
            Direction.Left =>{ 
                self.direction = direction;
                new_location.x -= @divFloor(self.size, 2);
            },
            Direction.Right =>{ 
                self.direction = direction;
                new_location.x += @divFloor(self.size, 2);
            },
            Direction.None => {
                switch (self.direction) {
                    Direction.Up => new_location.y -= @divFloor(self.size, 2),
                    Direction.Down => new_location.y += @divFloor(self.size, 2),
                    Direction.Left => new_location.x -= @divFloor(self.size, 2),
                    Direction.Right => new_location.x += @divFloor(self.size, 2),
                    Direction.None => {},
            }},
        }
        
        self.location = new_location;
    }
};

//if (rl.isKeyPressed(keys.UP)) {
//   if (snake.y > 0 + snake.size) {
//   } 
// else if (rl.isKeyPressed(keys.DOWN)) {
//   if (snake.y < HEIGHT - snake.size) {
//       snake.y  ;
//   } 
//

//f (rl.isKeyPressed(keys.LEFT)) {
//   if (snake.x > 0 + snake.size) {
//       snake.x  ;
//   }
// else if (rl.isKeyPressed(keys.RIGHT)) {
//   if (snake.x < WIDTH - snake.size) {
//       snake ;
//   }

