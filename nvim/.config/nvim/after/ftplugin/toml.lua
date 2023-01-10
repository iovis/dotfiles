---- muxi
if string.match(vim.fn.expand("%"), "muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
end
