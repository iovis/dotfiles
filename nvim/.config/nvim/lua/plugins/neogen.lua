return {
  "danymat/neogen",
  event = "VeryLazy",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local neogen = require("neogen")

    neogen.setup({
      snippet_engine = "luasnip",
    })

    vim.keymap.set("n", "<leader>an", neogen.generate, {
      desc = "Neogen generate annotation",
    })
  end,
}
