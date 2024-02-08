return {
  -- Functions
  s(
    "f",
    fmta(
      [[
      func <fname>(<args>) <ret_type><space>{
        <body>
      }
      ]],
      {
        fname = i(1, "fname"),
        args = i(2),
        space = n(3, " "),
        ret_type = i(3),
        body = i(0, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fm",
    fmta(
      [[
      func (<struct>) <fname>(<args>) <ret_type><space>{
        <body>
      }
      ]],
      {
        struct = i(1, "r *Receiver"),
        fname = i(2, "fname"),
        args = i(3),
        space = n(4, " "),
        ret_type = i(4),
        body = i(0, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fh",
    fmta(
      [[
      func <fname>(<res> http.ResponseWriter, <req> *http.Request) {
        <body>
      }
      ]],
      {
        fname = c(1, {
          i(1, "fname"),
          fmt("({} {}) {}", { i(1, "receiver"), i(2, "type"), i(3, "fname") }),
        }),
        res = i(2, "w"),
        req = i(3, "r"),
        body = i(4, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Structs
  s(
    "st",
    fmta(
      [[
      type <> struct {
        <>
      }
      ]],
      {
        i(1, "Name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Conditionals
  s(
    "if",
    fmta(
      [[
      if <> {
        <>
      }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "ife",
    fmta(
      [[
      if <> {
        <>
      } else {
        <>
      }
      ]],
      { i(1), i(2), i(3) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "el",
    fmta(
      [[
      else {
        <>
      }
      ]],
      { i(1) }
    ),
    { condition = conds.line_begin }
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
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fori",
    fmt(
      [[
        for {} := 0; {} < {}; {}++ {{
          {}
        }}
      ]],
      {
        i(1, "i"),
        rep(1),
        i(2, "10"),
        rep(1),
        i(3),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "forl",
    fmt(
      [[
        for {} := range {} {{
          {}
        }}
      ]],
      { i(1, "item"), i(2, "collection"), i(3) }
    ),
    { condition = conds.line_begin }
  ),
  -- Misc
  s(
    "pln",
    fmt("fmt.Println({})", {
      i(1),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "prf",
    fmta('fmt.Printf("<>"<comma><>)', {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
