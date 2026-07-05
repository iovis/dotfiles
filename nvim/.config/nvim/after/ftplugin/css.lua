local u = require("config.utils")

if u.current_file():match("waybar") then
  local augroup = vim.api.nvim_create_augroup("waybar_reload", { clear = false })
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload waybar config on save",
    group = augroup,
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.cmd("silent !killall -SIGUSR2 waybar")
    end,
  })
end
