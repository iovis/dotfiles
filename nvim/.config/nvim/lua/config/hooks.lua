local M = {}

---- Check for outdated Cargo.toml dependencies (EXPERIMENTAL)
function M.run_cargo_outdated()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns = vim.api.nvim_create_namespace("cargo_dependencies")

  -- Clear virtual text and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, bufnr)

  local toml = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  local find_pkg = function(name)
    local pattern = string.format("^%s = ", name)

    for i, line in ipairs(toml) do
      if line:match(pattern) then
        return i - 1 -- nvim is 0 based
      end
    end

    vim.notify(string.format("Couldn't find %s", name), vim.log.levels.ERROR)
  end

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
        local pkg_line_number = find_pkg(package.name)
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

  local package_json = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  local find_pkg = function(name)
    for i, line in ipairs(package_json) do
      local pkg_name = string.format('"%s":', name)

      -- Find string literally (no pattern matching)
      if line:find(pkg_name, nil, true) then
        return i - 1 -- nvim is 0 based
      end
    end

    vim.notify(string.format("Couldn't find %s", name), vim.log.levels.ERROR)
  end

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
        local pkg_line_number = find_pkg(package)
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
        vim.bo.filetype = "rspec"

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
    file,
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
