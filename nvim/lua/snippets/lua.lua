return {
  s("u", t('local u = require("utils")')),
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
