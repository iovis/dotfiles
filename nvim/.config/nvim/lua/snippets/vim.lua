return {
  s(
    "f",
    fmt(
      [[
        function! {name}({})
          {}
        endfunction
      ]],
      {
        name = i(1, "function_name"),
        i(2),
        i(0),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "fs",
    fmt(
      [[
        function! s:{name}({}) abort
          {}
        endfunction
      ]],
      {
        name = i(1, "function_name"),
        i(2),
        i(0),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "luab",
    fmt(
      [[
        lua <<EOF
        {}
        EOF
      ]],
      { i(0) },
      {
        condition = conds.line_begin,
      }
    )
  ),
}
