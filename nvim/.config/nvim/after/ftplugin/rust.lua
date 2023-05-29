vim.cmd.compiler("cargo")

vim.keymap.set("n", "c<cr>", "<cmd>Tux! irust<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", "<cmd>Tux cargo check --all-targets && clippy<cr>", { buffer = true })

vim.keymap.set("n", "<leader>sn", "<cmd>TestNearest -strategy=rust_print<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", "<cmd>TestNearest -strategy=rust_log<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sr", "<cmd>RustReloadWorkspace<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sw", "<cmd>Tux cargo watch --clear -x check -x 'nextest run'<cr>", { buffer = true })

vim.keymap.set("n", "+R", ":RustDocs<space>", { buffer = true })

if vim.fn.expand("%"):match("examples/") then
  -- if inside example, run it
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run -q --example %:t:r<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("benches/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo bench -q --bench %:t:r<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("ext/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle exec rake compile<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run<cr>", { buffer = true })
end

----Surround debug
require("nvim-surround").buffer_setup({
  surrounds = {
    ["d"] = {
      add = { "dbg!(", ")" },
      find = "dbg!%b()",
      delete = "^(dbg!%()().-(%))()$",
    },
  },
})
