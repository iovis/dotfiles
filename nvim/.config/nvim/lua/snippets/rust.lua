local function rust_fn()
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

local function rust_method()
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
        args = c(2, {
          fmta("&self<>", { r(1, "arg", i(1)) }),
          fmta("&mut self<>", { r(1, "arg", i(1)) }),
        }),
        arrow = n(3, " -> "),
        ret_type = i(3),
        body = i(4, "todo!()"),
      }
    )
  )
end

return {
  s(
    "#!",
    fmta(
      [[
        #!/usr/bin/env -S cargo +nightly -Zscript -q

        //! ```cargo
        //! [dependencies]
        //! <>
        //! ```

        fn main() {
            <>
        }
      ]],
      {
        i(1, 'clap = { version = "4.2", features = ["derive"] }'),
        i(2, "todo!();"),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  -- Functions
  s("f", d(1, rust_fn), {
    condition = conds.line_begin,
  }),
  s("pf", fmt("pub {}", { d(1, rust_fn) }), {
    condition = conds.line_begin,
  }),
  s("af", fmt("async {}", { d(1, rust_fn) }), {
    condition = conds.line_begin,
  }),
  s("paf", fmt("pub async {}", { d(1, rust_fn) }), {
    condition = conds.line_begin,
  }),
  s("fm", d(1, rust_method), {
    condition = conds.line_begin,
  }),
  s("pfm", fmt("pub {}", { d(1, rust_method) }), {
    condition = conds.line_begin,
  }),
  s("afm", fmt("async {}", { d(1, rust_method) }), {
    condition = conds.line_begin,
  }),
  s("pafm", fmt("pub async {}", { d(1, rust_method) }), {
    condition = conds.line_begin,
  }),
  s(
    "axum_handler",
    fmt(
      [[
        #[axum::debug_handler]
        #[tracing::instrument{}]
        pub async {}
      ]],
      {
        i(1),
        d(2, rust_fn),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  -- Tests
  s(
    "test",
    fmta(
      [[
        #[test]
        fn <test_name>_test() {
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
  s(
    "tokiotest",
    fmta(
      [[
        #[tokio::test]
        async fn <test_name>_test() {
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
  s("ignore", t("#[ignore]"), { condition = conds.line_begin }),
  s("as", fmt("assert!({});", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ase", fmt("assert_eq!({}, {});", { i(1, "expected"), i(2, "actual") }), {
    condition = conds.line_begin,
  }),
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
  -- Tracing
  s("tinit", t("tracing_subscriber::fmt::init();"), {
    condition = conds.line_begin,
  }),
  s("instrument", fmt("#[tracing::instrument{}]", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("logd", fmt("tracing::debug!({});", { i(1, "?value") }), {
    condition = conds.line_begin,
  }),
  s("loge", fmt("tracing::error!({});", { i(1, "?value") }), {
    condition = conds.line_begin,
  }),
  s("logi", fmt("tracing::info!({});", { i(1, "?value") }), {
    condition = conds.line_begin,
  }),
  s("logw", fmt("tracing::warn!({});", { i(1, "?value") }), {
    condition = conds.line_begin,
  }),
  -- Macros
  s("attr", fmt("#[{}]", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("der", fmt("#[derive({}{})]", { i(1, "Debug"), i(2) }), {
    condition = conds.line_begin,
  }),
  s("allow", fmt("#[allow({})]", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("skipfmt", t("#[rustfmt::skip]"), { condition = conds.line_begin }),
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
    "ep",
    c(1, {
      fmta('eprintln!("<> = {<>:?}"<comma><>);', {
        r(1, "label", i(1)),
        dl(2, l._1, 1), -- dynamic lambda: repeat node 1 but let override
        comma = n(3, ", "),
        i(3),
      }),
      fmta('eprintln!("<> = {:?}", <>);', {
        r(1, "label", i(1)),
        dl(2, l._1, 1), -- dynamic lambda: repeat node 1 but let override
      }),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "fd",
    fmt("{field}: {value},", {
      field = i(1, "field"),
      value = i(2, "String"),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "pfd",
    fmt("pub {field}: {value},", {
      field = i(1, "field"),
      value = i(2, "String"),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s("r", fmt('r#"{}"#', { i(1) })),
  s("now", t("let now = std::time::Instant::now();"), {
    condition = conds.line_begin,
  }),
  s("elapsed", fmta('println!("<>{:?}", now.elapsed());', { i(1) }), {
    condition = conds.line_begin,
  }),
  s(".ins", t('.inspect(|x| eprintln!("{x:?}"))'), {
    condition = conds.line_begin,
  }),
  s(
    "sleep",
    fmt("std::thread::sleep(std::time::Duration::from_secs({}));", { i(1, "5") }),
    { condition = conds.line_begin }
  ),
  s(
    "aoc",
    fmta(
      [[
          fn main() {
              let input = include_str!("input.txt");

              println!("p1 = {:?}", p1(input));
              // println!("p2 = {:?}", p2(input));
          }

          fn p1(input: &str) ->> usize {
              <>
              todo!()
          }

          #[cfg(test)]
          mod tests {
              use super::*;

              #[test]
              fn p1_test() {
                  let input = indoc::indoc! {"
                      <>
                  "};

                  assert_eq!(p1(input), <>);
              }
          }
      ]],
      { i(1), i(2), i(0) }
    ),
    { condition = conds.line_begin }
  ),
}
