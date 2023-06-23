local u = require("config.utils")

local conventional_commit = function()
  return sn(
    nil,
    c(1, {
      sn(nil, fmt("({}): {}", { r(1, "scope", i(1)), r(2, "message", i(2)) })),
      sn(nil, fmt("({})!: {}", { r(1, "scope", i(1)), r(2, "message", i(2)) })),
    })
  )
end

local get_branch = function()
  return u.system("git rev-parse --abbrev-ref HEAD")
end

local get_jira_card = function()
  local jira_card = get_branch():match("%w+-%d+")

  if jira_card then
    jira_card = jira_card:upper()
  end

  return sn(nil, t(jira_card))
end

local get_jira_url = function(args)
  local jira_card = args[1][1]

  if u.is_empty(jira_card) then
    return sn(nil, t(""))
  end

  local jira_url = "[" .. jira_card .. "](https://rubiconmd.atlassian.net/browse/" .. jira_card .. ")"

  return sn(nil, t({ "", jira_url, "" }))
end

local extract_title_from_branch = function()
  local branch = get_branch()

  return branch:match("%w+-%d+_([%w_]+)") or branch:match("%w+/([%w_]+)") or branch
end

local get_pr_title = function()
  local title = extract_title_from_branch()
  title = u.titleize(title:gsub("_", " "))

  return sn(nil, i(1, title))
end

return {
  -- Conventional Commits
  s(
    { trig = "build", dscr = "Changes that affect the build system or external dependencies" },
    fmt("build{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "chore", dscr = "Other changes that dont modify src or test files" },
    fmt("chore{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "ci", dscr = "Changes to our CI configuration files and scripts" },
    fmt("ci{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "docs", dscr = "Documentation only changes" },
    fmt("docs{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "feat", dscr = "A new feature" },
    fmt("feat{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s({ trig = "fix", dscr = "A bug fix" }, fmt("fix{}", d(1, conventional_commit)), { condition = conds.line_begin }),
  s(
    { trig = "perf", dscr = "A code change that improves performance" },
    fmt("perf{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "refactor", dscr = "A code change that neither fixes a bug nor adds a feature" },
    fmt("refactor{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "revert", dscr = "Reverts a previous commit" },
    fmt("revert{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "style", dscr = "Changes that do not affect the meaning of the code" },
    fmt("style{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "test", dscr = "Adding missing tests or correcting existing tests" },
    fmt("test{}", d(1, conventional_commit)),
    { condition = conds.line_begin }
  ),
  -- Templates
  s(
    "master",
    fmt(
      [[
        master|{jira}{space}{title}
        {jira_url}
        **Related PRs:**
        - {}

        **Changelog:** {}
      ]],
      {
        jira = d(1, get_jira_card),
        space = n(1, " "),
        title = d(2, get_pr_title),
        jira_url = d(3, get_jira_url, { 1 }),
        i(4),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "qa",
    fmt(
      [[
        qa|{jira}{space}{title}
        {jira_url}
        **Changes:**
        - {changes}

        **How to test:**
        - {test}
      ]],
      {
        jira = d(1, get_jira_card),
        space = n(1, " "),
        title = d(2, get_pr_title),
        jira_url = d(3, get_jira_url, { 1 }),
        changes = i(4),
        test = i(5),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "coauthor",
    fmt(
      [[
        Co-authored-by: {name} <{email}>
      ]],
      { name = i(1), email = i(0) }
    ),
    { condition = conds.line_begin }
  ),
}
