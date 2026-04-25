local u = require("config.utils")

----PR Templates
-- Some functions get called more than once, so we store some of
-- the expensive results
local ctx = {}

---current directory name
---@return string
local function current_dir_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function current_dir()
  return sn(nil, t(current_dir_name()))
end

---@return string?
local function cargo_version()
  if not u.is_executable("cargo") then
    return nil
  end

  local manifest_path = vim.fs.find("Cargo.toml", {
    path = vim.fn.getcwd(),
    upward = true,
  })[1]

  if not manifest_path then
    return nil
  end

  local result = vim
    .system({ "cargo", "metadata", "--format-version=1", "--no-deps" }, {
      cwd = vim.fs.dirname(manifest_path),
      text = true,
    })
    :wait()

  if result.code ~= 0 then
    return nil
  end

  local ok, metadata = pcall(vim.json.decode, result.stdout or "")
  if not ok or type(metadata) ~= "table" or type(metadata.packages) ~= "table" then
    return nil
  end

  local package = metadata.packages[1]
  for _, candidate in ipairs(metadata.packages) do
    if candidate.manifest_path == manifest_path then
      package = candidate
      break
    end
  end

  if type(package) ~= "table" or type(package.version) ~= "string" then
    return nil
  end

  return package.version
end

---@return string
local function project_version()
  return cargo_version() or ""
end

local function release_version()
  return sn(nil, t(project_version()))
end

---get branch name
---@return string
local function get_branch()
  if not ctx.branch then
    ctx.branch = u.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" })
  end

  return ctx.branch
end

---get jira card from branch name
---@return string
local function get_jira_card()
  if ctx.jira_card then
    return ctx.jira_card
  end

  local jira_card = get_branch():match("%w+-%d+")

  if jira_card then
    ctx.jira_card = jira_card:upper()
  end

  return ctx.jira_card or ""
end

local function get_jira_url()
  local jira_card = get_jira_card()

  if not vim.env.JIRA_URL or u.is_empty(jira_card) then
    return sn(nil, t(""))
  end

  local jira_url = ("%s/browse/%s"):format(vim.env.JIRA_URL, jira_card)

  return sn(nil, t(jira_url))
end

----Conventional Commits
local function conventional_commit()
  local jira_card = get_jira_card()

  return sn(
    nil,
    c(1, {
      sn(
        nil,
        fmt("({}): {}", {
          r(1, "scope", i(1, jira_card)),
          r(2, "message", i(2)),
        })
      ),
      sn(
        nil,
        fmt("({})!: {}", {
          r(1, "scope", i(1, jira_card)),
          r(2, "message", i(2)),
        })
      ),
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
  s({ trig = "fix", dscr = "A bug fix" }, fmt("fix{}", d(1, conventional_commit)), {
    condition = conds.line_begin,
  }),
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
  -- Misc
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
  s("jira", fmt("JIRA: {jira_url}", { jira_url = d(1, get_jira_url) }), {
    condition = conds.line_begin,
  }),
  -- Templates
  s("release", fmt("release: {} v{}", { d(1, current_dir), d(2, release_version) }), {
    condition = conds.line_begin,
  }),
  s("plugins", t("chore(nvim.plugin): sync plugins"), {
    condition = conds.line_begin,
  }),
}
