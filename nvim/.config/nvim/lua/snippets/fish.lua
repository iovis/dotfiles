local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")
-- local parse = ls.parser.parse_snippet

return {
  s("shebang", t("#!/usr/bin/env fish"), { condition = conds.line_begin }),
  s(
    "if",
    fmt(
      [[
        if {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "elif",
    fmt(
      [[
        else if {}
            {}
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "switch",
    fmt(
      [[
        switch {}
            case{}
            case '*'
                echo fallback
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "case",
    fmt(
      [[
        case {}
            {}
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fun",
    fmt(
      [[
        function {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "begin",
    fmt(
      [[
        begin
            {}
        end
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "while",
    fmt(
      [[
        while {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "for",
    fmt(
      [[
        for {} in {}
            {}
        end
      ]],
      {
        i(1, "i"),
        i(2, "(seq 10)"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
}
