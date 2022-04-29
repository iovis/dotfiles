return {
  s(
    "coauthor",
    fmt(
      [[
        Co-authored-by: {name} <{email}>
      ]],
      { name = i(1), email = i(0) }
    )
  ),
}
