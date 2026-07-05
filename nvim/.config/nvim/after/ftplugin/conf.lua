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
elseif u.current_file():match(".ghostty$") then
  -- Only clean up autocmds belonging to this buffer
  local augroup = vim.api.nvim_create_augroup("ghostty_reload", { clear = false })
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload ghostty config on save",
    group = augroup,
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.cmd("silent !killall -SIGUSR2 ghostty")
    end,
  })

  vim.keymap.set("n", "s?", function()
    vim.cmd("vnew")
    vim.cmd("0r !ghostty +show-config --default --docs")
    vim.cmd.normal("gg")
    vim.bo.filetype = "conf"
    vim.bo.buftype = "nofile"
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buf = 0,
      nowait = true,
    })
  end, { buf = 0 })

  vim.keymap.set("n", "d?", function()
    vim.cmd("vnew")
    vim.cmd("0r !ghostty +list-keybinds")
    vim.cmd.normal("gg")
    vim.bo.filetype = "conf"
    vim.bo.buftype = "nofile"
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buf = 0,
      nowait = true,
    })
  end, { buf = 0 })
end
