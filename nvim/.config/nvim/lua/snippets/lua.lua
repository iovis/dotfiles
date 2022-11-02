return {
  s("u", t('local u = require("user.utils")')),
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
