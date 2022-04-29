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
  s(
    "try",
    fmt(
      [[
        try
          {}
        catch {}
          {}
        endtry
      ]],
      { i(1), i(2), i(0) }
    )
  ),
  s(
    "for",
    fmt(
      [[
        for {} in {}
          {}
        endfor
      ]],
      { i(1), i(2), i(0) }
    )
  ),
  s(
    "if",
    fmt(
      [[
        if {}
          {}
        endif
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    "ife",
    fmt(
      [[
        if {}
          {}
        else
          {}
        endif
      ]],
      { i(1), i(2), i(0) }
    )
  ),
}
