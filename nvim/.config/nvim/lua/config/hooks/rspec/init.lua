local M = {}

local u = require("config.utils")
local RSpec = require("config.hooks.rspec.model")

local job = { id = nil }

---Run RSpec for given path
function M.run()
  local rspec = RSpec:new()
  rspec:clear()

  if u.is_empty(vim.g.autotest) or job.id then
    return
  end

  rspec:progress_start()

  job.id = vim.fn.jobstart(rspec:command(vim.g.autotest), {
    stdout_buffered = true,
    on_stdout = function(_, data)
      job.id = nil

      if not rspec:parse(data) then
        rspec:parse_failure()
        print(table.concat(data, "\n"))

        return
      end

      rspec:set_virtual_text()
      rspec:set_diagnostics()
      rspec:create_buf_command()
      rspec:progress_end()
    end,
  })
end

return M
