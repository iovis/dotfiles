local tux = require("tux")
local u = require("config.utils")

vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set("n", "c<cr>", function()
  tux.pane("swift repl")
end, { buffer = true })

if not u.has_justfile() then
  if u.is_file("Package.swift") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux swift run<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux swift build<cr>", { buffer = true })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux swift %:.<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux swiftc %:.<cr>", { buffer = true })
  end
end
