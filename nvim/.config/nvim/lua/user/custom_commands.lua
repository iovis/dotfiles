local u = require("user.utils")

---- Cht.sh integration
---- Usage: Cht <query>
vim.api.nvim_create_user_command("Cht", function(opts)
  local command = 'tmux neww zsh -c "cht.sh ' .. opts.args .. ' | LESS="" less -R"'
  u.system(command)
end, { nargs = "+" })

vim.keymap.set("n", "+s", ":Cht<space>", { desc = "Run cht.sh query" })
