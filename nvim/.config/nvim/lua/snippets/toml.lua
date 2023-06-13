return {
  s(
    "bench",
    fmt(
      [=[
        [[bench]]
        name = "{}"
        harness = false
      ]=],
      {
        i(1, "main"),
      }
    ),
    { condition = conds.line_begin }
  ),
}
