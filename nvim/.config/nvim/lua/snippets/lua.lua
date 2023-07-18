return {
  -- Quick imports
  s("u", t('local u = require("config.utils")'), {
    condition = conds.line_begin,
  }),
  s("hi", t('local hi = require("config.highlights").hi'), {
    condition = conds.line_begin,
  }),
  s("c", t('local c = require("catppuccin.palettes").get_palette()'), {
    condition = conds.line_begin,
  }),
  -- Lua snippets
  s("as", fmt("--[[@as {}]]", { i(1, "<type>") })), -- TODO: Do alternate for `--[=[@as string[]]=]`
  s("pr", fmt("print({})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "prf",
    fmt([[print(string.format("{}"{comma}{}))]], {
      i(1),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s("dbg", fmt("vim.print({})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "pry",
    fmt(
      [[
        vim.cmd("messages clear")

        vim.print({})

        vim.cmd("R messages")
        vim.cmd("se ft=lua")
        vim.cmd("norm! G")
      ]],
      { i(1) }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s("logd", fmt('vim.notify("{}", vim.log.levels.DEBUG)', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("loge", fmt('vim.notify("{}", vim.log.levels.ERROR)', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logi", fmt('vim.notify("{}")', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logw", fmt('vim.notify("{}", vim.log.levels.WARN)', { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "fmt",
    fmt([[("{}").format({})]], {
      i(1),
      i(2),
    })
  ),
  s(
    "class",
    fmta(
      [[
        ---@class <>
        ---@field private my_field? string Description of `my field`
        local <> = {}

        ---<docs>
        function <>:new(<>)
          local instance = {<>}

          self.__index = self
          return setmetatable(instance, self)
        end
      ]],
      {
        rep(1),
        i(1, "class_name"),
        rep(1),
        i(2),
        i(3),
        docs = i(0),
      }
    ),
    { condition = conds.line_begin }
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
  -- Luasnip
  s(
    "s",
    fmta(
      [[
        s(
          "<>",
          <>,
          <>
        ),
      ]],
      { i(1), i(0), i(2, "{ condition = conds.line_begin }") }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "sfmt",
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
