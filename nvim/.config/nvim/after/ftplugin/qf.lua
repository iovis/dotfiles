-- For some reason you get a flash if you don't set this
vim.wo.winbar = ""

vim.keymap.set("n", "C", ":Cfilter<space>", {
  desc = "Filter QuickFix list",
  buffer = true,
})

vim.keymap.set("n", "<leader>A", "<cmd>Cfilter ^app<cr>", {
  desc = "Filter only items in `app/`",
  buffer = true,
})
