return {
  "rrethy/nvim-base16",
  lazy = false,
  priority = 1000,
  config = function()
    local h = require("config.highlights")

    require("base16-colorscheme").setup(h.base16_colors, {
      telescope = false,
      cmp = true,
    })

    h.custom_highlights()
  end,
}
