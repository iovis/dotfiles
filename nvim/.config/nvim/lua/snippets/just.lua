return {
  s(
    "init",
    fmt(
      [[
        set dotenv-load

        default: {}

        # lists available tasks
        @list:
            just --list

        # init project
        init:
            {}

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
        i(1, "init"),
        i(2, "bundle install"),
        i(3, "rails server"),
        i(4, 'open "$PROJECT_URL" -a "Google Chrome Canary"'),
        i(5, "rails console"),
        i(6, "rspec"),
        i(7, "pgcli $DATABASE_URL"),
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
