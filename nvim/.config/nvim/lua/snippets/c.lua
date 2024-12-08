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
    "munit",
    fmta(
      [[
        #include "unity.h"

        #include "<>"

        test<>

        const MunitTest munit_null_test = {NULL, NULL, NULL, NULL, MUNIT_TEST_OPTION_NONE, NULL};
        MunitTest test_suite_tests[] = {
          {"/test_name", test_name, NULL, NULL, MUNIT_TEST_OPTION_NONE, NULL},
          munit_null_test,
        };

        const MunitSuite test_suite = {
          "suite_name",
          test_suite_tests,
          NULL,
          1,
          MUNIT_SUITE_OPTION_NONE
        };

        int main(int argc, char *argv[]) {
          return munit_suite_main(&test_suite, NULL, argc, argv);
        }
      ]],
      {
        i(1, "my_library.h"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "test",
    fmta(
      [[
        static MunitResult test_<test_name>(const MunitParameter params[], void *data) {
          <>

          return MUNIT_OK;
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
