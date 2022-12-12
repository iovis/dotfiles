local u = require("user.utils")

u.lsp_autoformat()

vim.keymap.set("n", "m<cr>", "<cmd>Tux cargo check --all-targets<cr>", { buffer = true })
vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run<cr>", { buffer = true })

vim.keymap.set("n", "<leader>sn", "<cmd>TestNearest -strategy=rust_print<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", "<cmd>TestNearest -strategy=rust_log<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sr", "<cmd>RustReloadWorkspace<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sw", "<cmd>TuxBg! cw<cr>", { buffer = true })

vim.keymap.set("n", "+R", ":RustDocs<space>", { buffer = true })
