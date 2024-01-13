local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")
-- local parse = ls.parser.parse_snippet

return {
  -- Quick imports
  s("u", t('local u = require("config.utils")'), {
    condition = conds.line_begin,
  }),
  s("t", t('local tux = require("tux")'), {
    condition = conds.line_begin,
  }),
  s("hi", t('local hi = require("config.highlights").hi'), {
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
    "sinit",
    fmta(
      [[
        local ls = require("luasnip")
        local s = ls.snippet
        local sn = ls.snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node
        local l = require("luasnip.extras").lambda
        local rep = require("luasnip.extras").rep
        local p = require("luasnip.extras").partial
        local m = require("luasnip.extras").match
        local n = require("luasnip.extras").nonempty
        local dl = require("luasnip.extras").dynamic_lambda
        local fmt = require("luasnip.extras.fmt").fmt
        local fmta = require("luasnip.extras.fmt").fmta
        local conds = require("luasnip.extras.conditions")
        local parse = ls.parser.parse_snippet

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
  -- Test
  s("luassert", t('local assert = require("luassert")'), {
    condition = conds.line_begin,
  }),
  s(
    "desc",
    fmt(
      [[
        describe("{}", function()
          {}
        end)
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "bef",
    fmt(
      [[
        before_each(function()
          {}
        end)
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "aft",
    fmt(
      [[
        after_each(function()
          {}
        end)
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "it",
    fmt(
      [[
        it("{}", function()
          {}
        end)
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("ast", fmt("assert.is_true({})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("asnt", fmt("assert.is_not_true({})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ase", fmt("assert.are.equal({}, {})", { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s("ass", fmt("assert.are.same({}, {})", { i(1), i(2) }), {
    condition = conds.line_begin,
  }),
  s(
    "ashe",
    fmt(
      [[
        assert.has.error(function()
          {}
        end)
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
}
