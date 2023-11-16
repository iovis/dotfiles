return {
  "tpope/vim-dotenv",
  config = function()
    vim.g.autotest = vim.fn.DotenvGet("AUTOTEST")
  end,
}
