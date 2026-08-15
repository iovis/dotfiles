local function inside_impl()
  local node = vim.treesitter.get_node()

  while node do
    if node:type() == "block" then
      return false
    end

    if node:type() == "declaration_list" then
      return node:parent():type() == "impl_item"
    end

    node = node:parent()
  end

  return false
end

local function rust_function()
  if inside_impl() then
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

local preceding_attribute_nodes = {
  attribute_item = true,
  block_comment = true,
  line_comment = true,
}

local function has_cfg_test_attribute(item)
  local sibling = item:prev_named_sibling()

  while sibling and preceding_attribute_nodes[sibling:type()] do
    if sibling:type() == "attribute_item" then
      local attribute = sibling:named_child(0)
      local name = attribute and attribute:named_child(0)
      local arguments = attribute and attribute:named_child(1)

      if
        name
        and arguments
        and vim.treesitter.get_node_text(name, 0) == "cfg"
        and vim.treesitter.get_node_text(arguments, 0):gsub("%s+", "") == "(test)"
      then
        return true
      end
    end

    sibling = sibling:prev_named_sibling()
  end

  return false
end

local function inside_cfg_test_module()
  local node = vim.treesitter.get_node()

  while node do
    if node:type() == "mod_item" and has_cfg_test_attribute(node) then
      return true
    end

    node = node:parent()
  end

  return false
end

local function rust_modtest()
  if inside_cfg_test_module() then
    return sn(
      nil,
      fmta(
        [[
          mod <test_name>_tests {
              use super::*;

              <>
          }
        ]],
        {
          test_name = i(1, "name"),
          i(2),
        }
      )
    )
  end

  return sn(
    nil,
    fmta(
      [[
        #[cfg(test)]
        mod tests {
            use super::*;

            <>
        }
      ]],
      { i(1) }
    )
  )
end

local function rust_struct()
  return sn(
    nil,
    fmta(
      [[
        struct <> {
            <>
        }
      ]],
      { i(1), i(2) }
    )
  )
end

return {
  -- Functions/methods
  s("f", d(1, rust_function), {
    condition = conds.line_begin,
  }),
  s("pf", fmt("pub {}", { d(1, rust_function) }), {
    condition = conds.line_begin,
  }),
  s("af", fmt("async {}", { d(1, rust_function) }), {
    condition = conds.line_begin,
  }),
  s("paf", fmt("pub async {}", { d(1, rust_function) }), {
    condition = conds.line_begin,
  }),
  -- Tests
  s("modtest", d(1, rust_modtest), {
    condition = conds.line_begin,
  }),
  s(
    "t",
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
  s("ignore", t("#[ignore]"), {
    condition = conds.line_begin,
  }),
  s("as", fmt("assert!({});", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ase", fmt("assert_eq!({}, {});", { i(1, "expected"), i(2, "actual") }), {
    condition = conds.line_begin,
  }),
  -- Structs
  s("s", d(1, rust_struct), {
    condition = conds.line_begin,
  }),
  s("ps", fmt("pub {}", { d(1, rust_struct) }), {
    condition = conds.line_begin,
  }),
  -- Tracing
  s("tracinginit", t("tracing_subscriber::fmt::init();"), {
    condition = conds.line_begin,
  }),
  s(
    "tracingcompact",
    fmt(
      [[
        tracing_subscriber::fmt()
            .without_time()
            .with_target(false)
            .with_env_filter(EnvFilter::from_default_env())
            .init();
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
  s("tracinginstrument", fmt("#[tracing::instrument{}]", { i(1) }), {
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
  -- Misc
  s("rustfmt", t("#[rustfmt::skip]"), {
    condition = conds.line_begin,
  }),
  s("p", fmta('println!("{<>}");', { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "ep",
    c(1, {
      fmta('eprintln!("<> = {<>:?}");', {
        r(1, "label", i(1)),
        dl(2, l._1, 1), -- dynamic lambda: repeat node 1 but let override
      }),
      fmta('eprintln!("<> = {:?}", <>);', {
        r(1, "label", i(1)),
        dl(2, l._1, 1), -- dynamic lambda: repeat node 1 but let override
      }),
    }),
    { condition = conds.line_begin }
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
  s(".tap", t('.inspect(|x| eprintln!("{x:?}"))'), {
    condition = conds.line_begin,
  }),
  s(
    "sleep",
    fmt("std::thread::sleep(std::time::Duration::from_secs({}));", { i(1, "5") }),
    { condition = conds.line_begin }
  ),
  s("utf", fmt("std::str::from_utf8({}).unwrap()", { i(1) })),
  s(
    "aoc",
    fmta(
      [[
          fn main() {
              let input = include_str!("../input.txt");

              println!("p1 = {:?}", p1(input));
              println!("p2 = {:?}", p2(input));
          }

          fn p1(input: &str) ->> u64 {
              todo!()
          }

          fn p2(input: &str) ->> u64 {
              todo!()
          }

          #[cfg(test)]
          mod tests {
              use super::*;

              #[test]
              fn p1_test() {
                  #[rustfmt::skip]
                  let input = concat!(
                      <input>
                  );

                  assert_eq!(p1(input), <output>);
              }

              #[test]
              #[ignore = "pending"]
              fn p2_test() {
                  #[rustfmt::skip]
                  let input = concat!(
                      <input_repeat>
                  );

                  assert_eq!(p2(input), <output_repeat>);
              }
          }
      ]],
      {
        input = i(1, '"line\\n",'),
        input_repeat = rep(1),
        output = i(2, "123"),
        output_repeat = rep(2),
      }
    ),
    { condition = conds.line_begin }
  ),
}
