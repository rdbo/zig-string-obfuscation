const std = @import("std");

fn obfuscate(comptime str: []const u8) []u8 {
    // @compileLog("String: ", str);
    // @compileLog("Obfuscating...");

    var newstr: [str.len]u8 = undefined;

    // @compileLog("Chars: ");
    for (0.., str) |i, *c| {
        var newchar: u8 = c.*;
        if (c.* >= 'a' and c.* <= 'z') {
            if (c.* == 'z') {
                newchar = 'a';
            } else {
                newchar = c.* + 1;
            }
        } else if (c.* >= 'A' and c.* <= 'Z') {
            if (c.* == 'Z') {
                newchar = 'A';
            } else {
                newchar = c.* + 1;
            }
        }

        newstr[i] = newchar;
        // @compileLog(c.*, " -> ", newchar);
    }
    // @compileLog("\n");
    // @compileLog("Obfuscated string: ", newstr);

    return &newstr;
}

fn deobfuscate(comptime str: []const u8) []u8 {
    var newstr: [str.len]u8 = undefined;

    for (0.., str) |i, *c| {
        var newchar: u8 = c.*;
        if (c.* >= 'a' and c.* <= 'z') {
            if (c.* == 'a') {
                newchar = 'z';
            } else {
                newchar = c.* - 1;
            }
        } else if (c.* >= 'A' and c.* <= 'Z') {
            if (c.* == 'A') {
                newchar = 'Z';
            } else {
                newchar = c.* - 1;
            }
        }

        newstr[i] = newchar;
    }

    return &newstr;
}

pub fn main() void {
    const mystr = deobfuscate(comptime obfuscate("Hello World!"));
    std.debug.print("My String: {s}\n", .{mystr});
}
