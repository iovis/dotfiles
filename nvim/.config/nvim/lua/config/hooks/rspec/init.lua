local M = {}

local RSpec = require("config.hooks.rspec.model")

---Autorun RSpec tests (EXPERIMENTAL)
function M.run()
  local rspec = RSpec:new()

  rspec:clear()

  if not vim.g.autotest then
    return
  end

  rspec:create_buf_command()

  -- Run rspec
  vim.fn.jobstart({
    -- "spring",
    "rspec",
    "--format",
    "json",
    rspec.filename,
    -- string.format("%s:%s", rspec.filename, vim.fn.line(".")), -- only execute current context
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or not pcall(rspec.parse, rspec, data[1]) then
        vim.notify("Error parsing the RSpec output (not a valid JSON)", vim.log.levels.ERROR)
        return
      end

      rspec:set_virtual_text()
    end,
    on_exit = function()
      rspec:set_diagnostics()
    end,
  })
end

return M
