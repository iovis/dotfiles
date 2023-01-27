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

-- require("base16-colorscheme").colors

-- Grays
-- base00 = '#181818'
-- base01 = '#282828'
-- base02 = '#383838'
-- base03 = '#585858'
-- base04 = '#b8b8b8'
-- base05 = '#d8d8d8'
-- base06 = '#e8e8e8'
-- base07 = '#f8f8f8'

-- Colors
-- base08 = '#ab4642' -- red
-- base09 = '#dc9656' -- orange
-- base0A = '#f7ca88' -- light orange
-- base0B = '#a1b56c' -- green
-- base0C = '#86c1b9' -- blue/green
-- base0D = '#7cafc2' -- blue
-- base0E = '#ba8baf' -- magenta
-- base0F = '#a16946' -- dark orange
