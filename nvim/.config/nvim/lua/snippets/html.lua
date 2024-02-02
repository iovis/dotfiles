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
