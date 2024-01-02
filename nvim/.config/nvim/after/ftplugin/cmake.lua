vim.keymap.set("n", "m<cr>", "<cmd>Tux cmake --fresh -S . -B build<cr>", { buffer = true })
vim.keymap.set("n", "s<cr>", "<cmd>Tux cmake --fresh -S . -B build && cmake --build build<cr>", { buffer = true })
