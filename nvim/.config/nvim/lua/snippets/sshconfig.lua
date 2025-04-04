return {
  s(
    "host",
    fmt(
      [[
        Host {}
          Hostname {}
          User {}
          IdentityFile {}
      ]],
      {
        i(1, "name"),
        i(2, "rcc.local"),
        i(3, "david"),
        i(4, "~/.ssh/id_ed25519"),
      }
    ),
    { condition = conds.line_begin }
  ),
}
