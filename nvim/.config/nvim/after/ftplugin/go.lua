local u = require("config.utils")

vim.bo.expandtab = false

vim.keymap.set("n", "m<cr>", "<cmd>Tux go mod tidy<cr>", { buf = 0 })

---- Runnables
if u.current_file():match("_test.go") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux go test<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux go test -v<cr>", { buf = 0 })
elseif not u.has_justfile() then
  if u.is_file("go.mod") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux go run .<cr>", { buf = 0 })
    vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -re go -- go run .<cr>", { buf = 0 })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux go run %<cr>", { buf = 0 })
  end
end
