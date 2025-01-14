const std = @import("std");
const print = @import("std").debug.print;
const util = @import("util.zig");

const SPEED = 8;

pub const Direction = enum {
    Up,
    Down,
    Left,
    Right,
};


pub const Player = struct {
    location: util.Point,
    direction: Direction,
    head: [*:0]const u8,
    points: u32 = 0,

    pub fn init() Player {
        const location: util.Point = .{
            .x = util.WIDTH / 2,
            .y = util.HEIGHT / 2,
        };

        return Player{ .location = location, .direction = Direction.Right, .head = "=" };
    }

    pub fn change_direction(self: *Player, direction: Direction) void {
        self.direction = direction;
    }

    pub fn move(self: *Player) bool {
        if (util.in_bounds(self.location)) {
            switch (self.direction) {
                Direction.Up => {
                    self.location.y -= movement(util.SIZE);
                },
                Direction.Down => {
                    self.location.y += movement(util.SIZE);
                },
                Direction.Left => {
                    self.location.x -= movement(util.SIZE);
                },
                Direction.Right => {
                    self.location.x += movement(util.SIZE);
                },
            }
            return false;
        } else {
            return true;
        }
    }

    pub fn has_eaten(self: *Player, other: util.Point) bool {
        const boundary = util.BOUND/2;
        if ((self.location.x > (other.x - boundary)) and
            (self.location.x < (other.x + boundary)) and
            (self.location.y > (other.y - boundary)) and
            (self.location.y < (other.y + boundary))) {
            self.points += 1;
            return true;
        } else {
            return false;
        }
    }
};

fn movement(speed: i32) i32 {
    return @divFloor(speed, SPEED);
}


