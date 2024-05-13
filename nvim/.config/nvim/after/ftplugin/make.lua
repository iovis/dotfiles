vim.bo.expandtab = false
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

if vim.fn.expand("%"):match("rules.mk") then
  ---- QMK
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "d<cr>", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
end
