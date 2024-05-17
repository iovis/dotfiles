local u = require("config.utils")
local tux = require("tux")

vim.cmd.compiler("cargo")

vim.keymap.set("i", "<m-'>", "<c-o>A?")

vim.keymap.set("n", "c<cr>", function()
  tux.window("evcxr", {
    detached = false,
    select = true,
    name = "evcxr",
  })
end, { buffer = true })

vim.keymap.set("n", "<leader>sn", "<cmd>TestNearest -strategy=rust_print<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", "<cmd>TestNearest -strategy=rust_log<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sw", "<cmd>Tux cargo watch --clear -x check -x 'nextest run'<cr>", { buffer = true })

if vim.fn.expand("%"):match("examples/") then
  -- if inside example, run it
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run -q --example %:t:r<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("benches/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo bench -q --bench %:t:r<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("ext/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle exec rake<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e rs,rb -- bundle exec rake<cr>", { buffer = true })
elseif not u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux cargo run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux cargo check --all-targets && clippy<cr>", { buffer = true })
end

----Clippy fix
vim.api.nvim_buf_create_user_command(0, "ClippyFix", function()
  u.system({
    "cargo",
    "clippy",
    "--fix",
    "--allowdirty",
    "--",
    "-W",
    "clippy::pedantic",
  })

  vim.cmd("silent! checktime")
end, {})

----Surround
require("nvim-surround").buffer_setup({
  surrounds = {
    d = {
      add = { "dbg!(", ")" },
      find = "dbg!%b()",
      delete = "^(dbg!%()().-(%))()$",
    },
    o = {
      add = { "Ok(", ")" },
      find = "Ok%b()",
      delete = "^(Ok%()().-(%))()$",
    },
    s = {
      add = { "Some(", ")" },
      find = "Some%b()",
      delete = "^(Some%()().-(%))()$",
    },
  },
})
