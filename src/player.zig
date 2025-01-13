const print = @import("std").debug.print;
const bounds = @import("bounds.zig");

pub const Direction = enum {
    Up,
    Down,
    Left,
    Right,
};

const Point = struct {
    x: i32,
    y: i32,
};

pub const Player = struct {
    location: Point,
    size: i32,
    direction: Direction,
    head: [*:0]const u8,

    pub fn init() Player {
        const location: Point = .{
            .x = bounds.WIDTH / 2,
            .y = bounds.HEIGHT / 2,
        };

        return Player{ .location = location, .size = 20, .direction = Direction.Right, .head = "=" };
    }

    pub fn change_direction(self: *Player, direction: Direction) void {
        self.direction = direction;
    }

    pub fn move(self: *Player) bool {
        if (in_bounds(self.location)) {
            switch (self.direction) {
                Direction.Up => {
                    self.location.y -= movement(self.size);
                },
                Direction.Down => {
                    self.location.y += movement(self.size);
                },
                Direction.Left => {
                    self.location.x -= movement(self.size);
                },
                Direction.Right => {
                    self.location.x += movement(self.size);
                },
            }
            return false;
        } else {
            return true;
        }
    }
};

fn movement(speed: i32) i32 {
    return @divFloor(speed, 8);
}

fn in_bounds(location: Point) bool {
    return (location.x > bounds.LEFT_BOUND) and
        (location.x < (bounds.RIGHT_BOUND - bounds.BOUND)) and
        (location.y > bounds.UPPER_BOUND) and
        (location.y < bounds.LOWER_BOUND - bounds.BOUND);
}
