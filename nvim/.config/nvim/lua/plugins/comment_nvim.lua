-- Supports block comments too, unlike the native one
return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()

    ----`gcu` mapping (leverages native neovim text object)
    vim.keymap.set("n", "gcu", "gcgc", { remap = true })
  end,
}
