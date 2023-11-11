local u = require("config.utils")

vim.keymap.set("n", "<leader>aa", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

---- runnables
if vim.fn.expand("%"):match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake compile<cr>", { buffer = true })
else
  if u.is_file("justfile") then
    vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- just run<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- just build<cr>", { buffer = true })

    vim.keymap.set("n", "<leader>sw", "<cmd>Tux just dev<cr>", { buffer = true })
  else
    vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- make run<cr>", { buffer = true })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- make<cr>", { buffer = true })

    vim.keymap.set("n", "<leader>sw", "<cmd>Tux ls **/*.c | entr -c make<cr>", { buffer = true })
  end
end
