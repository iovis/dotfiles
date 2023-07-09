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

  local dependencies = {}
  for _, package in ipairs(json.dependencies) do
    table.insert(dependencies, {
      name = package.name,
      version = package.latest,
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
