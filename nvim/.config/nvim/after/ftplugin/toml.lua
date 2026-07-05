local u = require("config.utils")

---- muxi
if u.current_file():match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buf = 0 })
elseif u.current_file() == "Cargo.toml" then
  if vim.g.custom_hooks then
    -- Only clean up autocmds belonging to this buffer
    local augroup = vim.api.nvim_create_augroup("cargo_dependencies", { clear = false })
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      desc = "Check Cargo dependencies",
      group = augroup,
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        require("config.hooks.dependencies").run("cargo")
      end,
    })
  end
end
