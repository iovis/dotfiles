local rust_fn = function()
  return sn(
    nil,
    fmta(
      [[
        fn <fname>(<args>)<ret_type> {
            <body>
        }
      ]],
      {
        fname = i(1, "fname"),
        args = i(2),
        ret_type = c(3, {
          {
            t(" -> "),
            i(1),
          },
          t(""),
        }),
        body = i(4, "todo!()"),
      }
    )
  )
end

return {
  -- Functions
  s({ trig = "fn", dscr = "function" }, d(1, rust_fn), { condition = conds.line_begin }),
  s({ trig = "pfn", dscr = "pub function" }, fmt("pub {}", { d(1, rust_fn) }), { condition = conds.line_begin }),
  s({ trig = "afn", dscr = "async function" }, fmt("async {}", { d(1, rust_fn) }), { condition = conds.line_begin }),
  s(
    { trig = "pafn", dscr = "pub async function" },
    fmt("pub async {}", { d(1, rust_fn) }),
    { condition = conds.line_begin }
  ),
  -- Tests
  s(
    { trig = "tt", dscr = "Tokio test" },
    fmta(
      [[
        #[tokio::test]
        async fn <test_name>() {
            <>
        }
      ]],
      {
        test_name = i(1, "test_name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Structs
  s(
    "st",
    fmta(
      [[
      struct <> {
          <>
      }
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    "pst",
    fmta(
      [[
        pub struct <> {
            <>
        }
      ]],
      { i(1), i(0) }
    )
  ),
  -- Misc
  s("pln", fmt('println!("{}"{});', { i(1), i(2) })),
  parse("dbg", "dbg!($1);"),
  s("fd", fmt("{field}: {value},", { field = i(1, "field"), value = i(2, "value") }), { condition = conds.line_begin }),
  s(
    "pfd",
    fmt("pub {field}: {value},", { field = i(1, "field"), value = i(2, "value") }),
    { condition = conds.line_begin }
  ),
  s("r", fmt('r#"{}"#', { i(1) })),
}