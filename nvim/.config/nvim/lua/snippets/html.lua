return {
  s(
    "block",
    fmta(
      [[
        {{ block "<>" . }}
        <>
        {{ end }}
      ]],
      {
        i(1, "name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "if",
    fmta(
      [[
        {{ if <> }}
        <>
        {{ end }}
      ]],
      {
        i(1, "."),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "range",
    fmta(
      [[
        {{ range <> }}
        <>
        {{ end }}
      ]],
      {
        i(1, "."),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "template",
    fmta(
      [[
        {{ template "<>" <> }}
      ]],
      {
        i(1, "name"),
        i(2, "."),
      }
    ),
    { condition = conds.line_begin }
  ),
}
