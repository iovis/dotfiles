return {
  "saecki/crates.nvim",
  tag = "v0.3.0",
  ft = { "rust", "toml" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jose-elias-alvarez/null-ls.nvim", -- code actions
  },
  config = function()
    require("crates").setup({
      highlight = {
        version = "Comment",
      },
      null_ls = {
        enabled = true,
      },
      popup = {
        autofocus = true,
        border = "rounded",
      },
      text = {
        version = "    %s", -- Extra space to make room for lspsaga's lightbulb
      },
    })
  end,
}
