local tux = require("tux")
local u = require("config.utils")

vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.keymap.set("n", "c<cr>", function()
  tux.pane("swift repl")
end, { buf = 0 })

if not u.has_justfile() then
  if u.is_file("Package.swift") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux swift run<cr>", { buf = 0 })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux swift build<cr>", { buf = 0 })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux swift %:.<cr>", { buf = 0 })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux swiftc %:.<cr>", { buf = 0 })
  end
end
