return {
  s("u", t('local u = require("user.utils")')),
  s("hi", t('local hi = require("user.utils").hi')),
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
    )
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
    )
  ),
  -- Snippets
  s(
    "snipinit",
    fmta(
      [[
        return {
          s("<>", <>),
        }
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s("s", fmt([[s("{}", {}),]], { i(1), i(0) })),
  s(
    "fmt",
    fmta("fmt(<>, {<>})", {
      c(1, {
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
        sn(nil, fmt([["{}"]], i(1))),
      }),
      i(0),
    })
  ),
}
