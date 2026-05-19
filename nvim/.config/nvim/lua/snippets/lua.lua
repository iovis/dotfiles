local u = require("config.utils")

local function lua_fn()
  return sn(
    nil,
    fmta(
      [[
        function<space><fname>(<args>)
          <body>
        end
      ]],
      {
        fname = i(1, "fname"),
        space = n(1, " "),
        args = i(2),
        body = dl(3, l.LS_SELECT_DEDENT),
      }
    )
  )
end

return {
  -- Neovim
  s(
    "augroup",
    fmta(
      [[
        local augroup = vim.api.nvim_create_augroup("<>", { clear = true })
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "autocmd",
    fmta(
      [[
        vim.api.nvim_create_autocmd(<>, {
          group = <>,
          pattern = <>,
          callback = function()
            <>
          end,
        })
      ]],
      {
        i(1, '"User"'),
        i(2, "augroup"),
        i(3, '"VeryLazy"'),
        i(0, "-- TODO"),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- .nvim.lua
  s(
    "filetype",
    fmta(
      [[
        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("my.filetype", { clear = true }),
          pattern = { "<>" },
          callback = function()
            <>
          end,
        })
      ]],
      {
        i(1, "c"),
        i(0, "-- TODO"),
      }
    ),
    {
      show_condition = u.ls.within(".nvim.lua"),
      condition = conds.line_begin * u.ls.within(".nvim.lua"),
    }
  ),
  s(
    "rubylsp",
    fmta(
      [[
        vim.lsp.config("ruby_lsp", {
          init_options = {
            formatter = "<>",
            linters = { "<>" },
          },
        })
      ]],
      {
        i(1, "standard"),
        i(2, "standard"),
      }
    ),
    {
      show_condition = u.ls.within(".nvim.lua"),
      condition = conds.line_begin * u.ls.within(".nvim.lua"),
    }
  ),
  s(
    "lsp",
    fmta([[vim.lsp.enable({ "<>" })]], {
      i(1, "ruby_lsp"),
    }),
    {
      show_condition = u.ls.within(".nvim.lua"),
      condition = conds.line_begin * u.ls.within(".nvim.lua"),
    }
  ),
  -- Functions
  s("f", d(1, lua_fn), {
    condition = conds.line_begin,
  }),
  s("lf", fmt("local {}", { d(1, lua_fn) }), {
    condition = conds.line_begin,
  }),
  -- Quick imports
  s("u", t('local u = require("config.utils")'), {
    condition = conds.line_begin,
  }),
  s("t", t('local tux = require("tux")'), {
    condition = conds.line_begin,
  }),
  s("hi", t('local hi = require("config.ui.highlights").hi'), {
    condition = conds.line_begin,
  }),
  s("c", t('local c = require("catppuccin.palettes").get_palette()'), {
    condition = conds.line_begin,
  }),
  -- Lua
  s("styluaignore", t("-- stylua: ignore"), {
    condition = conds.line_begin,
  }),
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
    fmt([[("{}"):format({})]], {
      i(1),
      i(2),
    })
  ),
  s(
    "class",
    fmta(
      [[
        ---@class (exact) <>
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
    "sinit",
    fmta(
      [[
        return {
          s<>
        }
      ]],
      { i(0) }
    ),
    { condition = conds.line_begin }
  ),
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
