local u = require("config.utils")

if u.current_file():match("docker-compose.yml") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux pcup<cr>", { buf = 0 })
end
