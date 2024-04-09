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
    "templ",
    fmta(
      [[
      templ <component>(<args>) {
        <body>
      }
      ]],
      {
        component = i(1, "component"),
        args = i(2),
        body = i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "url",
    fmta([[templ.URL(fmt.Sprintf("<>"))]], {
      i(1, "/"),
    })
  ),
}
