local function module_name()
  local path = vim.fn.expand("%:t:r")

  return sn(nil, i(1, path))
end

return {
  s(
    "main",
    fmta(
      [[
        #include <<stdio.h>>

        int main(int argc, char *argv[]) {
          <body>

          return 0;
        }
      ]],
      {
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "maintest",
    fmta(
      [[
        #include <<stdio.h>>

        int main(void) {
          <>

          puts("ok");
          return 0;
        }
      ]],
      {
        i(1, "some_test();"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "include",
    fmt([[#include {}]], {
      c(1, {
        fmt([["{}.h"]], { d(1, module_name) }),
        fmt([[<{}.h>]], { i(1, "stdio") }),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "f",
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
    "sf",
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
        VALUE <fname>(VALUE self<comma><args>) {
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
          r(2, "body", i(2)),
          r(1, "name", i(1)),
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
  s(
    "clangformat",
    fmt(
      [[
        // clang-format off
        {visual_selection}
        // clang-format on
      ]],
      {
        visual_selection = dl(1, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "modtest",
    fmta(
      [[
        #ifdef TEST
        <>
        #endif
      ]],
      { i(1) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "test",
    fmta(
      [[
        static void <test_name>_test(void) {
          <>
        }
      ]],
      {
        test_name = i(1, "name"),
        i(2, "// TODO"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "tests",
    fmta(
      [[
        void <test_name>_tests(void)<>
      ]],
      {
        test_name = d(1, module_name),
        c(2, {
          t(";"),
          fmta(
            [[
              {
                <>
              }
            ]],
            { i(1, "// TODO") }
          ),
        }),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("ase", fmt("assert({});", { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "p",
    fmta([[printf("<>\n"<comma><>);]], {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "ep",
    fmta([[fprintf(stderr, "<>\n"<comma><>);]], {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "dp",
    fmta(
      [[
        fprintf(stderr, "[%s:%d:%s] <> = %<>\n", __FILE__, __LINE__, __func__, <>);
      ]],
      {
        i(1, "var"),
        i(2, "d"),
        dl(3, l._1, 1), -- dynamic lambda: repeat node 1 but let override
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "debug",
    fmta([[dbg("<> = %<>", <>);]], {
      i(1, "var"),
      i(2, "d"),
      dl(3, l._1, 1), -- dynamic lambda: repeat node 1 but let override
    }),
    { condition = conds.line_begin }
  ),
}
