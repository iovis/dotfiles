local meeting_title = function()
  local calendar_cmd = table.concat({
    "icalBuddy",
    "--noCalendarNames",
    "--excludeAllDayEvents",
    -- "--includeCals ''",
    "--bullet ''",
    "--includeEventProps 'title'",
    "eventsNow",
  }, " ")
  local events = vim.fn.systemlist(calendar_cmd)

  if #events == 0 then
    return sn(nil, i(1, ""))
  elseif #events == 1 then
    return sn(nil, i(1, events[1]))
  else
    local choices = {}

    for _, event in ipairs(events) do
      table.insert(choices, i(1, event))
    end

    return sn(nil, c(1, choices))
  end
end

return {
  s("li", fmt("[{}]({})", { i(1), i(2) })),
  s("img", fmt("![{}]({})", { i(1), i(2) })),
  s({ trig = "[", dscr = "Insert checkbox", snippetType = "autosnippet" }, {
    c(1, {
      fmt("[ ] {}", { r(1, "title", i(1)) }),
      fmt("[x] {}", { r(1, "title", i(1)) }),
    }),
  }, {
    condition = function(line_to_cursor, _matched_trigger, _captures)
      -- optional whitespace followed by `- [`
      return line_to_cursor:match("^%s*- %[$")
    end,
  }),
  s(
    { trig = "c", dscr = "Code block" },
    fmt(
      [[
        ```{}
        {}
        ```
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  -- Quick title
  s(
    { trig = "t", dscr = "Quick title" },
    fmt(
      [[
        # [{date}] {title}

        {}
      ]],
      {
        date = p(os.date, "%F"),
        title = i(1, "Title"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Meeting notes
  s(
    { trig = "m", dscr = "Meeting notes" },
    fmt(
      [[
        # [{date}] {title}

        - {}
      ]],
      {
        date = p(os.date, "%F"),
        title = d(1, meeting_title),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Callouts
  s("note", { t({ "> [!NOTE]", "> " }), i(1) }, {
    condition = conds.line_begin,
  }),
  s("tip", { t({ "> [!TIP]", "> " }), i(1) }, {
    condition = conds.line_begin,
  }),
  s("important", { t({ "> [!IMPORTANT]", "> " }), i(1) }, {
    condition = conds.line_begin,
  }),
  s("warn", { t({ "> [!WARNING]", "> " }), i(1) }, {
    condition = conds.line_begin,
  }),
  s("caution", { t({ "> [!CAUTION]", "> " }), i(1) }, {
    condition = conds.line_begin,
  }),
}
