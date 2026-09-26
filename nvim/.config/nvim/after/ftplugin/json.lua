local u = require("config.utils")

---- package.json
if u.current_file() == "package.json" then
  if vim.g.custom_hooks then
    -- Only clean up autocmds belonging to this buffer
    local augroup = vim.api.nvim_create_augroup("node_dependencies", { clear = false })
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      desc = "Check Node dependencies",
      group = augroup,
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        require("config.hooks.dependencies").run("npm")
      end,
    })
  end
elseif u.current_file():match("swaync/") then
  -- Only clean up autocmds belonging to this buffer
  local augroup = vim.api.nvim_create_augroup("swaync_reload", { clear = false })
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

  -- /etc/xdg/swaync/config.json
  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload SwayNC on save",
    group = augroup,
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.cmd("silent !systemctl --user restart swaync.service")
    end,
  })
end

vim.keymap.set("n", "'J", ":silent %!jq '.'<left>", { buf = 0 })
vim.keymap.set("n", "'f", ":R !jq '.'<left> %", { buf = 0 })
