return {
  "rrethy/nvim-base16",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-default-dark")
  end,
}
