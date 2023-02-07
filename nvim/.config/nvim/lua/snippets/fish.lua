return {
  s("shebang", t("#!/usr/bin/env fish"), { condition = conds.line_begin }),
  s(
    "if",
    fmt(
      [[
        if {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "elif",
    fmt(
      [[
        else if {}
            {}
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "switch",
    fmt(
      [[
        switch {}
            case{}
            case '*'
                echo fallback
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "case",
    fmt(
      [[
        case {}
            {}
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fun",
    fmt(
      [[
        function {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "begin",
    fmt(
      [[
        begin
            {}
        end
      ]],
      {
        i(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "while",
    fmt(
      [[
        while {}
            {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "for",
    fmt(
      [[
        for {} in {}
            {}
        end
      ]],
      {
        i(1, "i"),
        i(2, "(seq 10)"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
}
