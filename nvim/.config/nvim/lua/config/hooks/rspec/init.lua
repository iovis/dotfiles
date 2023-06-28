local M = {}

local RSpec = require("config.hooks.rspec.model")

---Run RSpec for given path
function M.run()
  local rspec = RSpec:new()

  rspec:clear()

  if not vim.g.autotest or rspec.job_id then
    return
  end

  rspec:progress()

  local command = rspec:command(vim.g.autotest)

  -- Run RSpec
  rspec.job_id = vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not rspec:parse(data) then
        rspec:close()

        vim.notify("Error parsing the RSpec output (not a valid JSON)", vim.log.levels.ERROR)
        print(table.concat(data, "\n"))

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
