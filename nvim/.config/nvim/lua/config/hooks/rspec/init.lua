local M = {}

local RSpec = require("config.hooks.rspec.model")

---Autorun RSpec tests for current file
function M.run_current_file()
  local file = vim.fn.expand("%")

  M.run(file)
end

---Autorun RSpec tests for current file
function M.run_current_line()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local path = string.format("%s:%s", file, line)

  M.run(path)
end

---Run RSpec for given path
---@param path string
function M.run(path)
  local rspec = RSpec:new()

  rspec:clear()

  if not vim.g.autotest then
    return
  end

  -- Run rspec
  vim.fn.jobstart({
    -- "spring",
    "rspec",
    "--format",
    "json",
    path,
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or not pcall(rspec.parse, rspec, data[1]) then
        vim.notify("Error parsing the RSpec output (not a valid JSON)", vim.log.levels.ERROR)
        return
      end

      rspec:set_virtual_text()
      rspec:set_diagnostics()
      rspec:create_buf_command()
    end,
  })
end

return M
