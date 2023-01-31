local M = {}

local base16 = require("base16-colorscheme").colors

M.colors = {
  black = base16.base00, -- '#181818'
  gray1 = base16.base01, -- '#282828'
  gray2 = base16.base02, -- '#383838'
  gray3 = base16.base03, -- '#585858'
  gray4 = base16.base04, -- '#b8b8b8'
  gray5 = base16.base05, -- '#d8d8d8'
  gray6 = base16.base06, -- '#e8e8e8'
  gray7 = base16.base07, -- '#f8f8f8'

  red = base16.base08, -- '#ab4642'
  orange = base16.base09, -- '#dc9656'
  yellow = base16.base0A, -- '#f7ca88'
  green = base16.base0B, -- '#a1b56c'
  cyan = base16.base0C, -- '#86c1b9'
  blue = base16.base0D, -- '#7cafc2'
  magenta = base16.base0E, -- '#ba8baf'
  brown = base16.base0F, -- '#a16946'
}

--- Create highlight groups
---
--- hi.Comment = { fg="#ffffff", bg="#000000" }
--- hi.LspDiagnosticsDefaultError = 'DiagnosticError' -- Link to another group
M.hi = setmetatable({}, {
  ---@param hlgroup string
  ---@param args string|table
  __newindex = function(_, hlgroup, args)
    -- Link highlight group
    if "string" == type(args) then
      vim.api.nvim_set_hl(0, hlgroup, { link = args })
      return
    end

    vim.api.nvim_set_hl(0, hlgroup, args)
  end,
})

M.custom_highlights = function()
  local hi = M.hi
  local c = M.colors
  local feline_bg = "#212326"

  hi.CursorLineNr = { fg = c.gray4, bold = true }
  hi.LineNr = { fg = c.gray3 }

  hi.StatusLine = { fg = c.gray5, bg = feline_bg }
  hi.StatusLineNC = { fg = c.gray4, bg = feline_bg }

  hi.FloatBorder = { fg = c.gray3 }
  hi.VertSplit = { fg = feline_bg, bg = feline_bg }

  hi.DiffAdd = { fg = c.green }
  hi.DiffAdded = { fg = c.green }
  hi.DiffChange = { fg = c.gray3 }
  hi.DiffDelete = { fg = c.red, bold = true }
  hi.DiffRemoved = { fg = c.red, bold = true }
  hi.DiffText = { fg = c.blue, bold = true }

  hi.GitGutterAdd = "DiffAdd"
  hi.GitGutterChange = "DiffText"
  hi.GitGutterChangeDelete = { fg = c.base0E }
  hi.GitGutterDelete = "DiffDelete"

  ---- mini
  hi.MiniIndentscopeSymbol = { fg = c.gray1 }

  ---- lspsaga
  -- https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/highlight.lua
  hi.SagaBeacon = {} -- Flash when moving between diagnostics

  -- Code Action
  hi.ActionPreviewNormal = { link = "Comment" }
  hi.CodeActionText = { fg = c.gray4 }
  hi.LspSagaLightBulb = { fg = c.yellow }

  -- Diagnostic
  hi.DiagnosticSource = { link = "Comment" }

  -- Finder
  hi.FinderIcon = { link = "FinderType" }
  hi.FinderSelection = { fg = c.blue }
  hi.FinderSpinner = { link = "FinderSpinnerTitle" }
  hi.FinderSpinnerTitle = { fg = c.blue }
  hi.FinderType = { fg = c.yellow }
  hi.FinderVirtText = { link = "Comment" }

  -- Rename
  hi.RenameNormal = { fg = c.cyan }
end

return M
