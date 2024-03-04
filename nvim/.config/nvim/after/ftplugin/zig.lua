local u = require("config.utils")

vim.keymap.set("i", "<m-'>", ".{  }<left><left>")

if vim.fn.expand("%"):match("src/") and not u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig build run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig run %<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build-exe %<cr>", { buffer = true })
end
