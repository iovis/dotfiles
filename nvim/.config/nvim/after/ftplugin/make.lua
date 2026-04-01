local u = require("config.utils")

vim.bo.expandtab = false
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

if u.current_file():match("rules.mk") then
  ---- QMK
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buf = 0 })

  vim.keymap.set("n", "d<cr>", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buf = 0 })
end
