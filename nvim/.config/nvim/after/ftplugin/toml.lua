---- Check for outdated Cargo.toml dependencies (EXPERIMENTAL)
local run_cargo_outdated = function()
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
            { pkg_version, "DiagnosticHint" },
          },
        })
      end
    end,
  })
end

---- muxi
if vim.fn.expand("%"):match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buffer = true })
---- Cargo
elseif vim.fn.expand("%"):match("Cargo.toml") then
  local cargo_augroup = vim.api.nvim_create_augroup("cargo_dependencies", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check Cargo dependencies",
    buffer = vim.api.nvim_get_current_buf(),
    group = cargo_augroup,
    callback = run_cargo_outdated,
  })
end
