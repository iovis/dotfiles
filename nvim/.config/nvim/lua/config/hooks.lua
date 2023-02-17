local M = {}
local u = require("config.utils")

local find_pkg_in = function(doc, pattern)
  for i, line in ipairs(doc) do
    if line:match(pattern) then
      return i - 1 -- nvim is 0 based
    end
  end

  vim.notify(string.format("Couldn't find %s", pattern), vim.log.levels.ERROR)
end

---- Check for outdated Cargo.toml dependencies (EXPERIMENTAL)
function M.run_cargo_outdated()
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
        local pkg_line_number = find_pkg_in(doc, pattern)
        local pkg_version = string.format(" %s", package.latest)

        vim.api.nvim_buf_set_extmark(bufnr, ns, pkg_line_number, 0, {
          virt_text = {
            { pkg_version, "Comment" },
          },
        })
      end
    end,
  })
end

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
        local pkg_line_number = find_pkg_in(doc, pattern)
        local pkg_version = string.format(" %s", metadata.latest)

        vim.api.nvim_buf_set_extmark(bufnr, ns, pkg_line_number, 0, {
          virt_text = {
            { pkg_version, "Comment" },
          },
        })
      end
    end,
  })
end

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
        local pkg_line_number = find_pkg_in(doc, pattern)
        local pkg_version = string.format(" %s", pkg_latest)

        vim.api.nvim_buf_set_extmark(bufnr, ns, pkg_line_number, 0, {
          virt_text = {
            { pkg_version, "Comment" },
          },
        })

        ::continue::
      end
    end,
  })
end

---- Autorun rspec tests (EXPERIMENTAL)
function M.run_rspec()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.fn.expand("%")
  local ns = vim.api.nvim_create_namespace("rspec")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  if not vim.g.autotest then
    return
  end

  local failed_tests = {}

  -- Create buffer local command to show rspec failure
  vim.api.nvim_buf_create_user_command(bufnr, "RspecOutput", function()
    local line = vim.fn.line(".")

    for _, test in ipairs(failed_tests) do
      if test.line_number == line then
        vim.cmd("10new")

        vim.bo.bufhidden = "wipe"
        vim.bo.buflisted = false
        vim.bo.buftype = "nofile"
        vim.bo.filetype = "diff"

        vim.api.nvim_buf_set_lines(
          vim.api.nvim_get_current_buf(),
          0,
          -1,
          false,
          vim.tbl_flatten({
            test.full_description,
            "",
            vim.fn.split(test.exception.message, "\n"),
          })
        )

        return
      end
    end

    print("No RSpec output for this line")
  end, {})

  vim.keymap.set("n", "+R", ":RspecOutput<cr>", { buffer = true })

  -- Run rspec
  vim.fn.jobstart({
    -- "spring",
    "rspec",
    "--format",
    "json",
    -- file,
    string.format("%s:%s", file, vim.fn.line(".")), -- only execute current context
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      local ok, json = pcall(vim.json.decode, data[1])

      if not ok then
        vim.notify("Error parsing the RSpec output", vim.log.levels.ERROR)
        return
      end

      -- threshold to show timing the spec took
      local threshold = 0.01 -- second(s)

      for _, example in ipairs(json.examples) do
        local run_time = ""

        if example.run_time > threshold then
          run_time = string.format(" (%.2fs)", example.run_time)
        end

        -- example.status = passed|failed|pending
        if example.status == "passed" then
          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "✓ pass", "DiffAdded" },
              { run_time, "Comment" },
            },
          })
        elseif example.status == "failed" then
          table.insert(failed_tests, example)

          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "✗ failed", "DiagnosticVirtualTextError" },
              { run_time, "Comment" },
            },
          })
        elseif example.status == "pending" then
          vim.api.nvim_buf_set_extmark(bufnr, ns, example.line_number - 1, 0, {
            virt_text = {
              { "■ pending", "DiagnosticVirtualTextWarn" },
              { run_time, "Comment" },
            },
          })
        end
      end
    end,
    on_exit = function()
      local failed = {}

      for _, test in ipairs(failed_tests) do
        table.insert(failed, {
          bufnr = bufnr,
          lnum = test.line_number - 1,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          source = "rspec",
          message = test.full_description,
          user_data = {},
        })
      end

      vim.diagnostic.set(ns, bufnr, failed, {
        virtual_text = false,
      })
    end,
  })
end

return M
