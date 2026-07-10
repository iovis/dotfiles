local u = require("config.utils")

vim.opt_local.comments = ""
vim.opt_local.commentstring = "> %s"
vim.opt_local.textwidth = 80
vim.opt_local.formatoptions:append("tcoqnl1j")
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.spelllang = "en_us"
-- vim.opt_local.spell = true

if u.current_path():match("urls.txt") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux yt-dlp -a %<cr>", { buf = 0 })
end
