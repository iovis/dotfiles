local u = require("config.utils")

local Npm = {
  command = {
    "npm",
    "outdated",
    "--json",
  },
}

function Npm.parse_command_output(output)
  -- npm gives multiline json, gotta join first
  local json = vim.json.decode(table.concat(output, ""))

  local dependencies = {}
  for package, metadata in pairs(json) do
    table.insert(dependencies, {
      name = package,
      version = metadata.latest,
    })
  end

  return dependencies
end

function Npm.find_in(doc, package)
  -- ^    "@angular/core": "^14.2.8",
  local pattern = string.format('^%%s+"%s":', u.escape_lua_pattern(package.name))

  return u.find_pattern_in(doc, pattern)
end

return Npm
