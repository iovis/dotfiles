local u = require("config.utils")

local Cargo = {
  command = {
    "cargo",
    "outdated",
    "-R", -- only root dependencies
    "--format",
    "json",
  },
}

function Cargo.parse_command_output(output)
  local json = vim.json.decode(output[1])

  if not json then
    return
  end

  -- {
  --   "name": "clap",
  --   "project": "4.3.0",
  --   "compat": "4.3.19",
  --   "latest": "4.3.19",
  --   "kind": "Normal",
  --   "platform": null
  -- }
  local dependencies = {}
  for _, package in ipairs(json.dependencies) do
    table.insert(dependencies, {
      source = "cargo",
      name = package.name,
      current = package.project,
      latest = package.latest,
      message = ("%s %s (%s installed)"):format(package.name, package.latest, package.project),
    })
  end

  return dependencies
end

function Cargo.find_in(doc, package)
  -- ^clap = { version = "4.1.6", features = ["derive"] }
  local pattern = string.format("^%s = ", u.escape_lua_pattern(package.name))

  return u.find_pattern_in(doc, pattern)
end

return Cargo
