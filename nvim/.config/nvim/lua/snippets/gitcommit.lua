local u = require("utils")

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
  -- Labels
  s("brew", t("[brew] ")),
  s("gem", t("[gem] ")),
  s("git", t("[git] ")),
  s("pip", t("[pip] ")),
  s("skhd", t("[skhd] ")),
  s("tmux", t("[tmux] ")),
  s("vim", t("[vim] ")),
  s("wip", t("[WIP] ")),
  s("yabai", t("[yabai] ")),
  s("zsh", t("[zsh] ")),
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
    )
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
    )
  ),
  s(
    "coauthor",
    fmt(
      [[
        Co-authored-by: {name} <{email}>
      ]],
      { name = i(1), email = i(0) }
    )
  ),
}
