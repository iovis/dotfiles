return {
  { "neovim/nvim-lspconfig" },
  -- { "b0o/schemastore.nvim", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          keymaps = {
            apply_language_filter = ";",
          },
        },
      })

      vim.keymap.set("n", "<leader>lu", "<cmd>Mason<cr>")
    end,
  },
}
