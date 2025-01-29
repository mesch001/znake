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
    points: u32 = 0,
    tails: [255]util.Point = undefined,
    num_tails: u8 = 0,
    new_tail: bool = false,

    pub fn init() Player {
        const location: util.Point = .{
            .x = util.WIDTH / 2,
            .y = util.HEIGHT / 2,
        };

        return Player{ .location = location, .direction = Direction.Right };
    }

    pub fn change_direction(self: *Player, direction: Direction) void {
        self.direction = direction;
    }

    pub fn move(self: *Player) bool {
        if (util.in_bounds(self.location)) {
            if (!eat_self(self)) {
                const distance = util.SPRITE_SIZE / 8;

                var current = self.location;
                for (0..self.num_tails) |i| {
                    const save = self.tails[i];
                    self.tails[i] = current;
                    current = save;
                }

                const location = self.location;

                switch (self.direction) {
                    Direction.Up => {
                        self.location.y -= distance;
                    },
                    Direction.Down => {
                        self.location.y += distance;
                    },
                    Direction.Left => {
                        self.location.x -= distance;
                    },
                    Direction.Right => {
                        self.location.x += distance;
                    },
                }

                if (self.new_tail) {
                    self.add_tail(location);
                    self.new_tail = false;
                }

                return false;
            } else {
                return true;
            }
        } else {
            return true;
        }
    }

    pub fn has_eaten(self: *Player, other: util.Point) bool {
        const boundary = util.BOUND / 2;
        if ((self.location.x > (other.x - boundary)) and
            (self.location.x < (other.x + boundary)) and
            (self.location.y > (other.y - boundary)) and
            (self.location.y < (other.y + boundary)))
        {
            self.new_tail = true;
            return true;
        } else {
            return false;
        }
    }

    fn eat_self(self: *Player) bool {
        for (self.tails) |tail| {
            if (self.location.x == tail.x and self.location.y == tail.y) {
                return true;
            }
        }
        return false;
    }

    fn add_tail(self: *Player, location: util.Point) void {
        self.points += 1;
        self.tails[self.num_tails] = location;
        self.num_tails += 1;
    }
};
