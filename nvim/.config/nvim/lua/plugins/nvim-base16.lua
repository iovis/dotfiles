return {
  "rrethy/nvim-base16",
  lazy = false,
  priority = 1000,
  config = function()
    require("base16-colorscheme").with_config({
      telescope = false,
      cmp = true,
    })

    vim.cmd.colorscheme("base16-default-dark")
  end,
}
