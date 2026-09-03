local u = require("config.utils")

vim.bo.tabstop = 4
vim.bo.expandtab = false

---- Runnables
if u.is_file("go.mod") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux go run .<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux go mod tidy && go build .<cr>", { buf = 0 })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -re go -- go run .<cr>", { buf = 0 })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux go run %:.<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux go build %:.<cr>", { buf = 0 })
end
