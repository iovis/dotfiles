return {
  s(
    "f",
    fmta(
      [[
      <ret_type> <fname>(<args>) {
        <body>
      }
      ]],
      {
        ret_type = i(1, "void"),
        fname = i(2, "fname"),
        args = i(3, "void"),
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
}
