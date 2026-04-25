local function zig_fn()
  return sn(
    nil,
    fmta(
      [[
        fn <fname>(<args>) <ret_type> {
            <body>
        }
      ]],
      {
        fname = i(1, "fname"),
        args = i(2),
        ret_type = i(3, "!void"),
        body = i(4),
      }
    )
  )
end

return {
  s(
    "main",
    fmta(
      [[
        const std = @import("std");

        pub fn main(init: std.process.Init) !void {
            <>
        }
      ]],
      {
        i(0, [[std.debug.print("Hello World!\n", .{});]]),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- Functions
  s("f", d(1, zig_fn), {
    condition = conds.line_begin,
  }),
  s("pf", fmt("pub {}", { d(1, zig_fn) }), {
    condition = conds.line_begin,
  }),

  -- Structs
  s(
    "st",
    fmta(
      [[
        const <> = struct {
            <>
        };
      ]],
      { i(1, "Name"), i(2) }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "enum",
    fmta(
      [[
        const <> = enum {
            <>
        };
      ]],
      { i(1, "name"), i(2) }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "union",
    fmta(
      [[
        const <> = union(<>) {
            <>
        };
      ]],
      { i(1, "name"), i(2, "enum"), i(3) }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "errenum",
    fmta(
      [[
        const <> = error {
            <>
        };
      ]],
      { i(1, "Err"), i(2) }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- Tests
  s(
    "test",
    fmta(
      [[
        test "<>" {
            <>
        };
      ]],
      { i(1), i(0) }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- If/else
  s(
    "if",
    fmta(
      [[
        if (<>) {
            <>
        }
      ]],
      { i(1), i(0) }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- Loops
  s(
    "for",
    fmta(
      [[
        for <> {
            <>
        }
      ]],
      {
        c(1, {
          fmt("({})", { i(1) }),
          fmt("({}) |{}|", { i(1, "list"), i(2, "value") }),
          fmt("({}, 0..) |{}, {}|", { i(1, "list"), i(2, "value"), i(3, "i") }),
        }),
        i(2),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "while",
    fmta(
      [[
        while <> {
            <>
        }
      ]],
      {
        c(1, {
          fmt("({})", { i(1) }),
          fmt("({}) : ({})", { i(1, "i < n"), i(2, "i += 1") }),
        }),
        i(0),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- Imports
  s("std", t('const std = @import("std");'), {
    condition = conds.line_begin,
  }),
  s(
    "import",
    fmt('const {} = @import("{}");', {
      i(1, "std"),
      dl(2, l._1, 1), -- pre-populate from node 1
    }),
    { condition = conds.line_begin }
  ),
}
