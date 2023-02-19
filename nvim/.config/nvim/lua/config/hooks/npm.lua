local M = {}
local u = require("config.utils")

---- Check for outdated package.json dependencies (EXPERIMENTAL)
function M.run_npm_outdated()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("node_dependencies")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  local doc = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  -- Run npm outdated
  vim.fn.jobstart({
    "npm",
    "outdated",
    "--json",
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      -- npm gives multiline json, gotta join first
      local raw_json = table.concat(data, "")
      local ok, json = pcall(vim.json.decode, raw_json)

      if not ok then
        vim.notify("Error parsing the npm output", vim.log.levels.ERROR)
        return
      end

      for package, metadata in pairs(json) do
        -- ^    "@angular/core": "^14.2.8",
        local pattern = string.format('^%%s+"%s":', u.escape_lua_pattern(package))
        local pkg_line_number = u.find_pattern_in(doc, pattern)
        local pkg_version = string.format(" %s", metadata.latest)

        vim.api.nvim_buf_set_extmark(bufnr, ns, pkg_line_number, 0, {
          hl_mode = "combine",
          virt_text = {
            { pkg_version, "Comment" },
          },
        })
      end
    end,
  })
end

return M
