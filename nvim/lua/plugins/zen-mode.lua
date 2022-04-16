require("zen-mode").setup({
  window = {
    backdrop = 1,
    height = 0.9,
    width = 0.8,
    options = {
      -- Any vim.wo options
      signcolumn = "no",
      number = false,
      relativenumber = false,
    },
  },
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>")
