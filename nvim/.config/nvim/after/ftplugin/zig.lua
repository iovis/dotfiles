local u = require("config.utils")

vim.keymap.set("i", "<m-'>", ".{  }<left><left>")

if u.current_file():match("src/") and not u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig build run<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build<cr>", { buf = 0 })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig run %:.<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build-exe %:.<cr>", { buf = 0 })
end
