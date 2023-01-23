local rust_fn = function()
  return sn(
    nil,
    fmta(
      [[
        fn <fname>(<args>)<arrow><ret_type> {
            <body>
        }
      ]],
      {
        fname = i(1, "fname"),
        args = i(2),
        arrow = n(3, " -> "),
        ret_type = i(3),
        body = i(4, "todo!()"),
      }
    )
  )
end

return {
  -- Functions
  s(
    {
      trig = "fn",
      dscr = "function",
    },
    d(1, rust_fn),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "pfn",
      dscr = "pub function",
    },
    fmt("pub {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "afn",
      dscr = "async function",
    },
    fmt("async {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "pafn",
      dscr = "pub async function",
    },
    fmt("pub async {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
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
    ),
    {
      condition = conds.line_begin,
    }
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
    ),
    {
      condition = conds.line_begin,
    }
  ),
  -- Misc
  s(
    "pln",
    fmta('println!("{<>}"<comma><>);', {
      i(1),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "pd",
    fmta('println!("<> = {<>:?}"<comma><>);', {
      i(1),
      dl(2, l._1, 1), -- dynamic lambda: repeat node 1 but let override
      comma = n(3, ", "),
      i(3),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "fd",
    fmt("{field}: {value},", {
      field = i(1, "field"),
      value = i(2, "value"),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "pfd",
    fmt("pub {field}: {value},", {
      field = i(1, "field"),
      value = i(2, "value"),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s("r", fmt('r#"{}"#', { i(1) })),
  s("now", t("let now = std::time::Instant::now();"), {
    condition = conds.line_begin,
  }),
  s("elapsed", t('println!("{:?}", now.elapsed());'), {
    condition = conds.line_begin,
  }),
}
