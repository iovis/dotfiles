local M = {}
local u = require("config.utils")

---- Check for outdated Gemfile dependencies (EXPERIMENTAL)
function M.run_bundle_outdated()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("bundle_dependencies")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  local doc = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  -- Run npm outdated
  vim.fn.jobstart({
    "bundle",
    "outdated",
    "--only-explicit",
    "--parseable",
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        if u.is_empty(line) then
          goto continue
        end

        -- line => puma (newest 6.1.0, installed 5.6.5, requested ~> 5.6.5)
        local pkg_name, pkg_latest = line:match("([%w._-]+) %(newest ([%d.]+)")

        if not pkg_name or not pkg_latest then
          vim.notify(string.format("Error parsing line: %s", line), vim.log.levels.ERROR)
          return
        end

        -- ^  gem "bullet", '~> 7.0.1'
        local pattern = string.format("^%%s*gem%%s*[\"']%s[\"']", u.escape_lua_pattern(pkg_name))
        local pkg_line_number = u.find_pattern_in(doc, pattern)
        local pkg_version = string.format(" %s", pkg_latest)

        vim.api.nvim_buf_set_extmark(bufnr, ns, pkg_line_number, 0, {
          hl_mode = "combine",
          virt_text = {
            { pkg_version, "Comment" },
          },
        })

        ::continue::
      end
    end,
  })
end

return M
