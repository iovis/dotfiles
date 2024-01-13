local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")
-- local parse = ls.parser.parse_snippet

return {
  s(
    "alternate",
    fmta(
      [[
        "<>": {
          "alternate": "<>"
        },
      ]],
      {
        i(1, "app/*.rb"),
        i(2, "spec/{}_spec.rb"),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  s(
    "proj",
    fmta(
      [[
        {
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          }
        }
      ]],
      {
        i(1, "app/*.rb"),
        i(2, "spec/{}_spec.rb"),
        i(3, "spec/*_spec.rb"),
        i(4, "app/{}.rb"),
        i(5, "Gemfile"),
        i(6, "Gemfile.lock"),
        rep(6),
        rep(5),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  s(
    "rails",
    fmta(
      [[
        {
          "app/*.rb": {
            "alternate": "spec/{}_spec.rb"
          },
          "spec/*_spec.rb": {
            "alternate": "app/{}.rb"
          },
          "lib/*.rb": {
            "alternate": "spec/lib/{}_spec.rb"
          },
          "spec/lib/*_spec.rb": {
            "alternate": "lib/{}.rb"
          },
          "Gemfile": {
            "alternate": "Gemfile.lock"
          },
          "Gemfile.lock": {
            "alternate": "Gemfile"
          }
        }
      ]],
      {},
      {
        condition = conds.line_begin,
      }
    )
  ),
}
