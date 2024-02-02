local u = require("config.utils")

vim.keymap.set("n", "m<cr>", "<cmd>Tux go mod tidy<cr>", { buffer = true })

if not u.has_justfile() then
  if u.is_file("go.mod") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux go run .<cr>", { buffer = true })
    vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -re go -- go run .<cr>", { buffer = true })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux go run %<cr>", { buffer = true })
  end
end
