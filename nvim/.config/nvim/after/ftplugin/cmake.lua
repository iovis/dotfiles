vim.keymap.set("n", "m<cr>", "<cmd>Tux cmake --fresh -S . -B build<cr>", { buf = 0 })
vim.keymap.set("n", "s<cr>", "<cmd>Tux cmake --fresh -S . -B build && cmake --build build<cr>", { buf = 0 })
