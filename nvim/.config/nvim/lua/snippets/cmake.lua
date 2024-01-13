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
    "init",
    fmta(
      [[
        cmake_minimum_required(VERSION <>)
        project(<> C)

        set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

        set(CMAKE_C_STANDARD 17)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")

        set(
          SOURCES
          src/main.c
        )

        add_executable(<> ${SOURCES})
      ]],
      {
        i(1, "3.28"),
        i(2, "name"),
        rep(2),
      }
    ),
    { condition = conds.line_begin }
  ),
}
