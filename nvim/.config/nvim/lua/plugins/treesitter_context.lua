return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      enable = true,
    })

    vim.keymap.set("n", "yot", "<cmd>TSContext toggle<cr>")
  end,
}
