vim.cmd.compiler("cargo")

vim.keymap.set("n", "c<cr>", "<cmd>Tux irust<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", "<cmd>Tux cargo check --all-targets && clippy<cr>", { buffer = true })

vim.keymap.set("n", "<leader>sn", "<cmd>TestNearest -strategy=rust_print<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", "<cmd>TestNearest -strategy=rust_log<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sr", "<cmd>RustReloadWorkspace<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sw", "<cmd>Tux cargo watch --clear -x check -x 'nextest run'<cr>", { buffer = true })

vim.keymap.set("n", "+R", ":RustDocs<space>", { buffer = true })

if string.match(vim.fn.expand("%"), "examples/") then
  -- if inside example, run it
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run -q --example %:t:r<cr>", { buffer = true })
elseif string.match(vim.fn.expand("%"), "benches/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo bench -q --bench %:t:r<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run<cr>", { buffer = true })
end
