vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

local u = require("config.utils")
if u.current_file():match("hypridle.conf") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux systemctl --user restart hypridle.service<cr>", { buf = 0 })
end
