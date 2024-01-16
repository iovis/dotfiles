local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local r = ls.restore_node
local n = require("luasnip.extras").nonempty
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")

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
    "rf",
    fmta(
      [[
        static VALUE <fname>(VALUE self<comma><args>) {
          <body>
        }
      ]],
      {
        fname = i(1, "fname"),
        comma = n(2, ", "),
        args = i(2),
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
