local u = require("config.utils")

----PR Templates
-- Some functions get called more than once, so we store some of
-- the expensive results
local ctx = {}

local get_branch = function()
  if not ctx.branch then
    ctx.branch = u.system("git rev-parse --abbrev-ref HEAD")
  end

  return ctx.branch
end

---@return table
local get_qa_prs = function()
  if ctx.prs then
    return ctx.prs
  end

  local branch = get_branch()
  local cmd = ([[gh pr list --head "%s" --base qa --search "sort:created-asc" --state all --json "title,url"]]):format(
    branch
  )

  local output = u.system(cmd, true)
  local ok, json = pcall(vim.json.decode, output)

  if ok then
    ctx.prs = json
  else
    vim.notify("There was an issue parsing the JSON", vim.log.levels.ERROR)
    vim.print(output)
    ctx.prs = {}
  end

  return ctx.prs
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

local get_master_pr_title = function()
  local qa_prs = get_qa_prs()
  local title

  if vim.tbl_isempty(ctx.prs) then
    title = u.titleize(extract_title_from_branch():gsub("_", " "))
  else
    -- Reuse title from QA PR (strip prefix)
    title = qa_prs[1].title:gsub([[^qa|%w+-%d+ ]], "")
  end

  return sn(nil, i(1, title))
end

local get_related_prs = function()
  local qa_prs = get_qa_prs()

  if vim.tbl_isempty(qa_prs) then
    return sn(nil, fmt("- {}", { i(1) }))
  else
    local pr_list = vim.tbl_map(function(item)
      return ("- %s"):format(item.url)
    end, qa_prs)

    return sn(nil, t(pr_list))
  end
end

----Conventional Commits
local conventional_commit = function()
  return sn(
    nil,
    c(1, {
      sn(nil, fmt("({}): {}", { r(1, "scope", i(1)), r(2, "message", i(2)) })),
      sn(nil, fmt("({})!: {}", { r(1, "scope", i(1)), r(2, "message", i(2)) })),
    })
  )
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
  s("plugins", t("chore(nvim.plugin): Sync plugins"), { condition = conds.line_begin }),
  s(
    "main",
    fmt(
      [[
        main|{jira}{space}{title}
        {jira_url}
        **Related PRs:**
        {qa_prs}

        **Changelog:** {}
      ]],
      {
        jira = d(1, get_jira_card),
        space = n(1, " "),
        title = d(2, get_master_pr_title),
        jira_url = d(3, get_jira_url, { 1 }),
        qa_prs = d(4, get_related_prs),
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
