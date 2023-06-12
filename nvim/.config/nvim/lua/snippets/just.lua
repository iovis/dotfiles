return {
  s(
    "main",
    fmt(
      [[
        # set dotenv-load  # Uncomment to load .env

        default: {}

        alias l := list

        # lists available tasks
        list:
            @just --list
      ]],
      {
        i(1, "list"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "a",
    fmt("alias {} := {}", {
      i(1, "name"),
      i(2, "task"),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "t",
    fmt(
      [[
        {}: {}
          {}
      ]],
      {
        i(1, "name"),
        i(2),
        i(3),
      }
    ),
    { condition = conds.line_begin }
  ),
}
