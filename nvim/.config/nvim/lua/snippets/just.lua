return {
  s(
    "main",
    fmt(
      [[
        # set dotenv-load  # Uncomment to load .env

        default: {}

        # lists available tasks
        list:
            @just --list

        # start the server
        dev:
            {}

        # open the project in the browser
        open:
            {}

        # start a console
        console:
            {}

        # run tests
        test:
            {}

        # Open the DB
        db:
            {}
      ]],
      {
        i(1, "list"),
        i(2, "dev"),
        i(3, "open"),
        i(4, "console"),
        i(5, "test"),
        i(6, "db"),
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
