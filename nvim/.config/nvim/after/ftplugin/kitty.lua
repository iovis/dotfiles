local u = require("config.utils")

if u.current_file():match("kitty.conf") then
  -- Only clean up autocmds belonging to this buffer
  local augroup = vim.api.nvim_create_augroup("kitty_reload", { clear = false })
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload kitty config on save",
    group = augroup,
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.cmd("silent !killall -SIGUSR1 kitty")
    end,
  })
end
