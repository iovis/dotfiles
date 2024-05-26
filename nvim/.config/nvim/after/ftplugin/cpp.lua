local u = require("config.utils")

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

if u.current_file():match("keyboards/") then
  ---- QMK
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "d<cr>", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
end
