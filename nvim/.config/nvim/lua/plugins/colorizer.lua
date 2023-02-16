return {
  "NvChad/nvim-colorizer.lua",
  -- enabled = false,
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "html",
        "scss",
        "svelte",
      },
      user_default_options = {
        names = false,
        RRGGBBAA = true,
        mode = "virtualtext",
      },
    })
  end,
}
