local meeting_title = function()
  local calendar_cmd = table.concat({
    "icalBuddy",
    "--noCalendarNames",
    "--excludeAllDayEvents",
    "--includeCals 'david.marchante@rubiconmd.com'",
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
    {
      condition = conds.line_begin,
    }
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
      },
      {
        condition = conds.line_begin,
      }
    )
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
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  -- Architecture interview notes for RubiconMD
  s(
    { trig = "architecture", dscr = "Architecture Interview notes for RubiconMD" },
    fmt(
      [[
        # [{date}] {title}

        ## requirements
        - {}

        ## data model
        -

        ## API
        -

        ## Notes
        -
      ]],
      {
        date = p(os.date, "%F"),
        title = d(1, meeting_title),
        i(0),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  -- integrations
  s(
    { trig = "integrations", dscr = "BE Interview notes for RubiconMD" },
    fmt(
      [[
        # [{date}] {title}

        ## Ask about BE experience (tech, frameworks)
        - {}

        ## Ask about integrations experience (challenges)
        -

        ## internet question
        -

        ## MVC like I'm a junior
        -

        ## welcome email
        -

        ## You have a view that is going to list the consults made by their organization and the author name. You realize that it’s taking a minute and a half for the controller to give this information to the view: What do you think is going on? How could we solve this performance issue?
        -

        ## Notes
        -
      ]],
      {
        date = p(os.date, "%F"),
        title = d(1, meeting_title),
        i(0),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  -- BE interview notes for RubiconMD
  s(
    { trig = "interview", dscr = "BE Interview notes for RubiconMD" },
    fmt(
      [[
        # [{date}] {title}

        ## internet question
        - {}

        ## welcome email
        -

        ## user password
        -

        ## performance
        -

        ## Notes
        -
      ]],
      {
        date = p(os.date, "%F"),
        title = d(1, meeting_title),
        i(0),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  -- DevOps interview
  s(
    { trig = "devops", dscr = "DevOps Interview notes for RubiconMD" },
    fmt(
      [[
        # [{date}] {title}

        ## internet question
        - {}

        ## Scaling from 1 instance
        -

        ## Automation/SDLC
        -

        ## Notes
        -
      ]],
      {
        date = p(os.date, "%F"),
        title = d(1, meeting_title),
        i(0),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  -- Release notes for RubiconMD
  s(
    { trig = "release", dscr = "Release notes for RubiconMD" },
    fmt(
      [[
      Good afternoon @here,

      Here's a summary of the changes deployed this morning:

      *Dev*
      {dev}


      *User/Ops*
      {user}


      Full release log is here:
      https://rubiconmd.atlassian.net/wiki/spaces/TECHNOLOGY/pages/836468765/2020-Q4

      Cheers,
      David
      ]],
      {
        dev = i(1, "Nothing today"),
        user = i(2, "Nothing today"),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
}
