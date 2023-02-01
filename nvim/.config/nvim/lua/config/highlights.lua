local M = {}

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

M.colors = {
  black = "#181818",
  gray1 = "#282828",
  gray2 = "#383838",
  gray3 = "#585858",
  gray4 = "#b8b8b8",
  gray5 = "#d8d8d8",
  gray6 = "#e8e8e8",
  gray7 = "#f8f8f8",

  red = "#ab4642",
  orange = "#dc9656",
  yellow = "#f7ca88",
  green = "#a1b56c",
  cyan = "#86c1b9",
  blue = "#7cafc2",
  magenta = "#ba8baf",
  brown = "#a16946",
}

M.base16_colors = {
  base00 = "#181818",
  base01 = "#282828",
  base02 = "#383838",
  base03 = "#585858",
  base04 = "#b8b8b8",
  base05 = "#d8d8d8",
  base06 = "#e8e8e8",
  base07 = "#f8f8f8",
  base08 = "#ab4642",
  base09 = "#dc9656",
  base0A = "#f7ca88",
  base0B = "#a1b56c",
  base0C = "#86c1b9",
  base0D = "#7cafc2",
  base0E = "#ba8baf",
  base0F = "#a16946",
}

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

  hi.DiagnosticSignError = { fg = c.red }
  hi.DiagnosticSignWarn = { fg = c.yellow }
  hi.DiagnosticSignInfo = { fg = c.blue }
  hi.DiagnosticSignHint = { fg = c.blue }

  hi.DiagnosticVirtualTextError = { fg = c.red }
  hi.DiagnosticVirtualTextWarn = { fg = c.yellow }
  hi.DiagnosticVirtualTextInfo = { fg = c.blue }
  hi.DiagnosticVirtualTextHint = { fg = c.blue }
end

return M
