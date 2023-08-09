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
  s("fn", d(1, zig_fn), {
    condition = conds.line_begin,
  }),
  s("pfn", fmt("pub {}", { d(1, zig_fn) }), {
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
  s(
    "switch",
    fmta(
      [[
        switch (<>) {
            <>
        }
      ]],
      { i(1), i(2) }
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

  -- Catch
  s(
    "cswitch",
    fmta(
      [[
        catch |<error>| switch (<>) {
            <>
        };
      ]],
      {
        error = i(1, "err"),
        rep(1),
        i(2),
      }
    )
  ),

  -- Printing
  s("dbg", fmta('std.debug.print("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("todo!", fmta('std.debug.todo("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("logd", fmta('std.log.debug("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("loge", fmta('std.log.error("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("logi", fmta('std.log.info("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("logw", fmta('std.log.warn("<>", .{ <> })', { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
}
