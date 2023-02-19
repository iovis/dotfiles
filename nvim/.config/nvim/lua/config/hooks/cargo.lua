local M = {}
local u = require("config.utils")

---Check for outdated Cargo.toml dependencies (EXPERIMENTAL)
function M.run()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("cargo_dependencies")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  local doc = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  -- Run cargo outdated
  vim.fn.jobstart({
    "cargo",
    "outdated",
    "-R", -- only root dependencies
    "--format",
    "json",
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      local ok, json = pcall(vim.json.decode, data[1])

      if not ok then
        vim.notify("Error parsing the cargo output", vim.log.levels.ERROR)
        return
      end

      for _, package in ipairs(json.dependencies) do
        -- ^clap = { version = "4.1.6", features = ["derive"] }
        local pattern = string.format("^%s = ", u.escape_lua_pattern(package.name))
        local pkg_line_number = u.find_pattern_in(doc, pattern)
        local pkg_version = string.format(" %s", package.latest)

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
