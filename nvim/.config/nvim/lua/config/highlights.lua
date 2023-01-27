local hi = require("config.utils").hi
local colors = require("base16-colorscheme").colors
local feline_bg = "#212326"

hi.CursorLineNr = { fg = colors.base04, bold = true }
hi.LineNr = { fg = colors.base03 }

hi.StatusLine = { fg = colors.base05, bg = feline_bg }
hi.StatusLineNC = { fg = colors.base04, bg = feline_bg }

hi.FloatBorder = { fg = colors.base03 }
hi.VertSplit = { fg = feline_bg, bg = feline_bg }

hi.DiffAdd = { fg = colors.base0B }
hi.DiffAdded = { fg = colors.base0B }
hi.DiffChange = { fg = colors.base03 }
hi.DiffDelete = { fg = colors.base08, bold = true }
hi.DiffRemoved = { fg = colors.base08, bold = true }
hi.DiffText = { fg = colors.base0D, bold = true }

hi.GitGutterAdd = "DiffAdd"
hi.GitGutterChange = "DiffText"
hi.GitGutterChangeDelete = { fg = colors.base0E }
hi.GitGutterDelete = "DiffDelete"
