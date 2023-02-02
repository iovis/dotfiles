return {
  "rrethy/nvim-base16",
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require("config.highlights").base16_colors

    require("base16-colorscheme").setup(colors, {
      telescope = false,
      cmp = true,
    })
  end,
}
