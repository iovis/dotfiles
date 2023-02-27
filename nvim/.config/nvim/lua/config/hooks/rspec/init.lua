local M = {}

local RSpec = require("config.hooks.rspec.model")

local strategy = {
  file = function()
    return vim.fn.expand("%")
  end,
  line = function()
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".")

    return string.format("%s:%s", file, line)
  end,
}

---Run RSpec for given path
function M.run()
  -- TODO: this instance is GLOBAL right now
  local rspec = RSpec:new()

  rspec:clear()

  if not vim.g.autotest or rspec.job_id then
    return
  end

  rspec:progress()

  pp(strategy[vim.g.autotest]())

  -- Run RSpec
  rspec.job_id = vim.fn.jobstart({
    -- "spring",
    "rspec",
    "--format",
    "json",
    strategy[vim.g.autotest](),
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or not pcall(rspec.parse, rspec, data[1]) then
        rspec:close()
        vim.notify("Error parsing the RSpec output (not a valid JSON)", vim.log.levels.ERROR)
        pp(data)
        return
      end

      rspec:set_virtual_text()
      rspec:set_diagnostics()
      rspec:create_buf_command()

      rspec:close()
    end,
  })
end

return M
