local u = require("config.utils")

if vim.fn.expand("%"):match("src/") then
  if u.is_file("justfile") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })

    vim.keymap.set("n", "<leader>sw", "<cmd>Tux just dev<cr>", { buffer = true })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux zig build run<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build<cr>", { buffer = true })

    vim.keymap.set("n", "<leader>sw", "<cmd>Tux ls **/*.zig | entr -c zig build run<cr>", { buffer = true })
  end
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig run %<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build-exe %<cr>", { buffer = true })
end
