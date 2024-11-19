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

  -- Start progress notification
  local fidget_key = ("dependencies_%s"):format(strategy)
  require("fidget").notify("In progress...", vim.log.levels.WARN, {
    annote = strategy,
    group = "dependencies",
    key = fidget_key,
    ttl = math.huge,
  })

  -- Capture contents of buffer to give to the parser
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
        print(data)
        require("fidget").notify("Error parsing output", vim.log.levels.ERROR, {
          annote = strategy,
          group = "dependencies",
          key = fidget_key,
          data = "✔", -- Force group to finish progress
          ttl = 3,
        })

        return
      end

      local diagnostics = vim
        .iter(dependencies)
        :map(function(dependency)
          local line_number = runner.find_in(spec_file, dependency)

          if not line_number then
            return nil
          end

          return {
            bufnr = bufnr,
            lnum = line_number,
            col = 0,
            severity = vim.diagnostic.severity.INFO,
            source = dependency.source,
            message = dependency.message,
            user_data = {},
          }
        end)
        :filter(function(diagnostic)
          return diagnostic
        end)
        :totable()

      vim.diagnostic.set(ns, bufnr, diagnostics)

      require("fidget").notify("Completed", vim.log.levels.INFO, {
        annote = strategy,
        group = "dependencies",
        key = fidget_key,
        data = "✔", -- Force group to finish progress
        ttl = 3,
      })
    end,
  })
end

return M
