const std = @import("std");
const util = @import("util.zig");

pub const Food = struct {
    location: util.Point,

    pub fn generate() Food {
        const seed: u128 = @bitCast(std.time.nanoTimestamp());
        var prng = std.rand.DefaultPrng.init(@truncate(seed));

        const x = std.rand.intRangeAtMost(prng.random(), i32, util.BOUND, (util.WIDTH - util.BOUND));
        const y = std.rand.intRangeAtMost(prng.random(), i32, util.BOUND, (util.HEIGHT - util.BOUND));

        const food = .{
            .x = x,
            .y = y,
        };

        return .{
            .location = food,
        };
    }
};
