if vim.fn.expand("%"):match("src/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig build run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux zig run %<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux zig build-exe %<cr>", { buffer = true })
end

-- vim.keymap.set("n", "<leader>sn", "<cmd>TestNearest -strategy=rust_print<cr>", { buffer = true })
-- vim.keymap.set("n", "<leader>sp", "<cmd>TestNearest -strategy=rust_log<cr>", { buffer = true })
-- vim.keymap.set("n", "<leader>sr", "<cmd>RustReloadWorkspace<cr>", { buffer = true })
-- vim.keymap.set("n", "<leader>sw", "<cmd>Tux cargo watch --clear -x check -x 'nextest run'<cr>", { buffer = true })
