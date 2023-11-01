local zig_fn = function()
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
  s(
    "eif",
    fmta(
      [[
        else if (<>) {
            <>
        }
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    "ife",
    fmta(
      [[
        if (<>) {
            <>
        } else {
            <>
        }
      ]],
      { i(1), i(2), i(0) }
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
      -- condition = conds.line_begin,
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

  -- Printing
  s(
    "stdout",
    fmta(
      [[
        const stdout = std.io.getStdOut().writer();
        try stdout.print("<>\n", .{<>});
      ]],
      {
        i(1),
        i(2),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  -- Misc
  s(
    "import",
    fmt('const {} = @import("{}");', {
      i(1),
      dl(2, l._1, 1), -- pre-populate from node 1
    }),
    { condition = conds.line_begin }
  ),
  s(".", fmta(".{ <> }", { i(1) }), {
    condition = function(line_to_cursor)
      -- Only expand if preceded by whitespace
      return line_to_cursor:match("^.*%s$")
    end,
  }),
}
