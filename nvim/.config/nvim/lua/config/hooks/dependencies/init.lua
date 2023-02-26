local M = {}

---Check for outdated dependencies
---@param strategy string Which runner to load
function M.run(strategy)
  local runner = require("config.hooks.dependencies." .. strategy)
  local bufnr = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("dependencies")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  local spec_file = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  -- Run command and parse results
  vim.fn.jobstart(runner.command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      local ok, dependencies = pcall(runner.parse_command_output, data)

      if not ok then
        vim.notify("Error parsing the output", vim.log.levels.ERROR)
        return
      end

      -- pp(dependencies)

      for _, package in ipairs(dependencies) do
        local version = string.format(" %s", package.version)
        local line_number = runner.find_in(spec_file, package)

        if line_number then
          vim.api.nvim_buf_set_extmark(bufnr, ns, line_number, 0, {
            hl_mode = "combine",
            virt_text = {
              { version, "Comment" },
            },
          })
        end
      end
    end,
  })
end

return M
