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

  -- "@angular/core": {
  --   "current": "16.1.5",
  --   "wanted": "16.1.8",
  --   "latest": "16.1.8",
  --   "dependent": "rubicon-angular",
  --   "location": "/<path>/node_modules/@angular/core"
  -- },
  local dependencies = {}
  for package, metadata in pairs(json) do
    if metadata.current then
      table.insert(dependencies, {
        source = "npm",
        name = package,
        current = metadata.current,
        latest = metadata.latest,
        message = ("%s %s (%s installed)"):format(package, metadata.latest, metadata.current),
      })
    end
  end

  return dependencies
end

function Npm.find_in(doc, package)
  -- ^    "@angular/core": "^14.2.8",
  local pattern = string.format('^%%s+"%s":', u.escape_lua_pattern(package.name))

  return u.find_pattern_in(doc, pattern)
end

return Npm
