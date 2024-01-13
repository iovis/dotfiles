local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
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
    "main",
    fmta(
      [[
        #include <<stdio.h>>

        int main(int argc, char *argv[]) {
          <body>
        }
      ]],
      {
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "pf",
    fmta(
      [[
        <ret_type> <fname>(<args>) {
          <body>
        }
      ]],
      {
        ret_type = i(1, "void"),
        fname = i(2, "fname"),
        args = i(3, "void"),
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "f",
    fmta(
      [[
        static <ret_type> <fname>(<args>) {
          <body>
        }
      ]],
      {
        ret_type = i(1, "void"),
        fname = i(2, "fname"),
        args = i(3, "void"),
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "st",
    c(1, {
      fmta(
        [[
          typedef struct {
            <>
          } <>;
        ]],
        {
          r(1, "body", i(1)),
          r(2, "name", i(2)),
        }
      ),
      fmta(
        [[
          struct <> {
            <>
          };
        ]],
        {
          r(1, "name", i(1)),
          r(2, "body", i(2)),
        }
      ),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
