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
  s(
    {
      trig = "f",
      dscr = "function",
    },
    d(1, rust_fn),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "pf",
      dscr = "pub function",
    },
    fmt("pub {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "af",
      dscr = "async function",
    },
    fmt("async {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "paf",
      dscr = "pub async function",
    },
    fmt("pub async {}", { d(1, rust_fn) }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "axh",
      dscr = "axum handler",
    },
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
    "modtest",
    fmta(
      [[
        #[cfg(test)]
        mod tests {
            use super::*;

            test<>
        }
      ]],
      {
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
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
        test_name = i(1, "test_name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "tokiotest", dscr = "Tokio test" },
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
  s("ignore", t("#[ignore]"), { condition = conds.line_begin }),
  s("as", fmt("assert!({});", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ase", fmt("assert_eq!({}, {});", { i(1, "expected"), i(2, "actual") }), {
    condition = conds.line_begin,
  }),
  -- Benchmarks
  s(
    "benchmain",
    fmta(
      [[
      use criterion::{black_box, criterion_group, criterion_main, Criterion};

      fn bench_fib(c: &mut Criterion) {
          c.bench_function("fib 20", |b| b.iter(|| fib(black_box(20))));
      }

      criterion_group!(benches, bench_fib);
      criterion_main!(benches);
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
  s(
    "bench",
    fmta(
      [[
      fn bench_fib(c: &mut Criterion) {
          c.bench_function("fib 20", |b| b.iter(|| fib(black_box(20))));
      }
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
  s(
    "benchgroup",
    fmta(
      [[
      fn bench_fibs(c: &mut Criterion) {
          let mut group = c.benchmark_group("Fibonacci");

          for i in &[5, 10, 100] {
              group.bench_with_input(BenchmarkId::new("Recursive", i), i, |b, i| {
                  b.iter(|| fibonacci_slow(*i));
              });

              group.bench_with_input(BenchmarkId::new("Iterative", i), i, |b, i| {
                  b.iter(|| fibonacci_fast(*i));
              });
          }

          group.finish();
      }
      ]],
      {}
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
  s("tracinginstrument", fmt("#[tracing::instrument{}]", { i(1) }), {
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
  s("elapsed", fmta('println!("<>{:?}", now.elapsed());', { i(1) }), {
    condition = conds.line_begin,
  }),
  s("inspect", t('.inspect(|x| eprintln!("{x:?}"))'), {
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
