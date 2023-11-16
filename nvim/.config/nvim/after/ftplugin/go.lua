local u = require("config.utils")

if not u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux go run .<cr>", { buffer = true })
end
