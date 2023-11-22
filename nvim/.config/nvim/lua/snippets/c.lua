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
    "st",
    c(1, {
      fmta(
        [[
          typedef struct <> {
            <>
          } <>;
        ]],
        {
          r(1, "name", i(1)),
          r(2, "body", i(2)),
          rep(1),
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
