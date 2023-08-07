local u = require("config.utils")

local Bundler = {
  command = {
    "bundle",
    "outdated",
    "--only-explicit",
    "--parseable",
  },
}

function Bundler.parse_command_output(output)
  local dependencies = {}

  for _, line in ipairs(output) do
    if u.is_empty(line) then
      goto continue
    end

    -- puma (newest 6.1.0, installed 5.6.5, requested ~> 5.6.5)
    -- attr_encrypted (newest 3.1.0 df02ab0, installed 3.1.0 eafd77a)
    -- view_component (newest 3.5.0, installed 2.56.2)
    local regex = "([%w._-]+) %(newest ([%d. a-f]+), installed ([%d. a-f]+)"
    local name, newer_version, installed_version = line:match(regex)

    if not name or not newer_version then
      vim.notify(string.format("Error parsing line: %s", line), vim.log.levels.ERROR)
      return
    end

    table.insert(dependencies, {
      name = name,
      version = newer_version,
      installed_version = installed_version,
    })

    ::continue::
  end

  return dependencies
end

function Bundler.find_in(doc, package)
  -- ^  gem "bullet", '~> 7.0.1'
  local pattern = string.format("^%%s*gem%%s*[\"']%s[\"']", u.escape_lua_pattern(package.name))

  return u.find_pattern_in(doc, pattern)
end

return Bundler
