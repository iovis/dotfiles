return {
  -- Quick imports
  s("u", t('local u = require("user.utils")'), {
    condition = conds.line_begin,
  }),
  s("hi", t('local hi = require("user.utils").hi'), {
    condition = conds.line_begin,
  }),
  -- Lua snippets
  s("pr", fmt("print({})", { i(1) })),
  s(
    "prf",
    fmt([[print(string.format("{}"{comma}{}))]], {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "mod",
    fmta(
      [[
        local <> = {
          <>
        }

        <>

        return <>
      ]],
      {
        i(1, "M"),
        i(2),
        i(3),
        rep(1),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "guard",
    fmt(
      [[
        local ok, {} = pcall(require, "{}")
        if not ok then
          print("{} not found!")
          return
        end

      ]],
      {
        i(1),
        dl(2, l._1, 1), -- pre-populate from node 1
        rep(2),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  -- Snippets
  s("s", fmt([[s("{}", {}),]], { i(1), i(0) }), {
    condition = conds.line_begin,
  }),
  s(
    "fmt",
    fmta("fmt(<>, {<>})", {
      c(1, {
        sn(nil, fmt([["{}"]], i(1))),
        sn(
          nil,
          fmt(
            [=[
              [[
                {}
              ]]
            ]=],
            i(1)
          )
        ),
      }),
      i(0),
    })
  ),
}
