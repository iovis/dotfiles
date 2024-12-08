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
    "unitymain",
    fmta(
      [[
        #include "unity.h"

        void setUp(void) {}
        void tearDown(void) {}

        void test_does_something(void) {
          TEST_ASSERT_EQUAL(1, 2);
        }

        int main(void) {
          UNITY_BEGIN();

          RUN_TEST(test_does_something);

          return UNITY_END();
        }
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
  s(
    "test",
    fmta(
      [[
        static void test_<test_name>(void) {
          <>
        }
      ]],
      {
        test_name = i(1, "name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
}
