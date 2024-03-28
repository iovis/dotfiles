return {
  -- Go templates
  s(
    "template",
    fmta('{{ template "<>" <> }}', {
      i(1, "name"),
      i(2, "."),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "block",
    fmta(
      [[
        {{ block "<>" . }}
        <visual_selection>
        {{ end }}
      ]],
      {
        i(1, "name"),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "define",
    fmta(
      [[
        {{ define "<>" }}
        <visual_selection>
        {{ end }}
      ]],
      {
        i(1, "layout"),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("else", t("{{ else }}"), { condition = conds.line_begin }),
  s(
    "if",
    fmta(
      [[
        {{ if <> }}
        <visual_selection>
        {{ end }}
      ]],
      {
        i(1, "."),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "range",
    fmta(
      [[
        {{ range <> }}
        <visual_selection>
        {{ end }}
      ]],
      {
        i(1, "."),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "with",
    fmta(
      [[
        {{ with <> }}
        <visual_selection>
        {{ end }}
      ]],
      {
        i(1, "."),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
}
