---- muxi
if vim.fn.expand("%"):match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("Cargo.toml") then
  ---- Cargo
end
