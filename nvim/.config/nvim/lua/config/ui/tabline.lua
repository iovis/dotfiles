local M = {}

local augroup = vim.api.nvim_create_augroup("user_tabline", { clear = true })

local function stl_escape(text)
  return tostring(text or ""):gsub("%%", "%%%%")
end

local function hl(group, text)
  if text == nil or text == "" then
    return ""
  end

  return ("%%#%s#%s"):format(group, stl_escape(text))
end

local function concat(parts)
  return table.concat(
    vim.tbl_filter(function(part)
      return part ~= nil and part ~= ""
    end, parts),
    ""
  )
end

local function catppuccin_palette()
  local ok, palette = pcall(function()
    return require("catppuccin.palettes").get_palette()
  end)

  if ok and type(palette) == "table" then
    return palette
  end

  return {
    blue = "#8caaee",
    crust = "#1e1e2e",
    green = "#a6d189",
    mantle = "#292c3c",
    overlay0 = "#737994",
    surface0 = "#414559",
    text = "#c6d0f5",
  }
end

local function set_highlights()
  local colors = catppuccin_palette()

  vim.api.nvim_set_hl(0, "UserTablineFill", {
    bg = "NONE",
    fg = colors.overlay0,
  })
  vim.api.nvim_set_hl(0, "UserTablineText", {
    bg = "NONE",
    fg = colors.overlay0,
  })
  vim.api.nvim_set_hl(0, "UserTablineTextSel", {
    bg = "NONE",
    fg = colors.text,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "UserTablineSeparator", {
    bg = "NONE",
    fg = colors.blue,
    bold = true,
  })
  vim.api.nvim_set_hl(0, "UserTablineModified", {
    bg = "NONE",
    fg = colors.green,
  })
end

local function tab_var(tabpage, name)
  local ok, value = pcall(vim.api.nvim_tabpage_get_var, tabpage, name)
  if ok then
    return value
  end
  return nil
end

local function custom_tab_name(tabpage)
  local name = tab_var(tabpage, "name")
  if type(name) ~= "string" then
    return nil
  end

  name = vim.trim(name)
  if name == "" then
    return nil
  end

  return name
end

local function buffer_title(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local buftype = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype

  if buftype == "help" then
    return "help:" .. vim.fn.fnamemodify(name, ":t:r")
  end

  if buftype == "quickfix" then
    return "quickfix"
  end

  if buftype == "terminal" then
    local _, term_type = name:match("^term:(.*):(%a+)$")
    if term_type and term_type ~= "" then
      return term_type
    end

    return vim.fn.fnamemodify(vim.env.SHELL or "", ":t")
  end

  if filetype == "TelescopePrompt" then
    return "Telescope"
  end

  if filetype == "git" then
    return "Git"
  end

  if filetype == "fugitive" then
    return "Fugitive"
  end

  if filetype == "fzf" then
    return "FZF"
  end

  if name == "" then
    return "[No Name]"
  end

  return vim.fn.fnamemodify(name, ":t")
end

local function shorten_label(label, max_width)
  if max_width <= 0 then
    return label
  end

  if vim.fn.strdisplaywidth(label) <= max_width then
    return label
  end

  local shortened = label
  if label:find("/", 1, true) or label:find("\\", 1, true) then
    shortened = vim.fn.pathshorten(label)
    if vim.fn.strdisplaywidth(shortened) <= max_width then
      return shortened
    end
  end

  local ellipsis = "…"
  if max_width <= vim.fn.strdisplaywidth(ellipsis) then
    return vim.fn.strcharpart(shortened, 0, max_width)
  end

  local keep = max_width - vim.fn.strdisplaywidth(ellipsis)
  return vim.fn.strcharpart(shortened, 0, keep) .. ellipsis
end

local function tab_title(tabpage)
  return custom_tab_name(tabpage) or buffer_title(vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage)))
end

local function tab_icon(tabpage)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return "", nil
  end

  local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
  local name = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(name, ":t")
  local extension = vim.fn.fnamemodify(name, ":e")
  local icon, icon_hl = devicons.get_icon(filename, extension)

  if not icon then
    icon, icon_hl = devicons.get_icon_by_filetype(vim.bo[bufnr].filetype, {
      default = true,
      strict = true,
    })
  end

  return icon or "", icon_hl
end

local function modified_indicator(tabpage)
  local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
  if not vim.bo[bufnr].modified then
    return "   "
  end

  return hl("UserTablineModified", " ● ")
end

local function label_budget(tab_count)
  local columns = math.max(vim.o.columns, 40)
  local available = math.max(columns - 4, 20)
  return math.min(18, math.max(10, math.floor(available / math.max(tab_count, 1)) - 2))
end

local function render_tab(index, tabpage, current_tabpage, max_width)
  local selected = tabpage == current_tabpage
  local title = shorten_label(tab_title(tabpage), max_width)
  local icon, icon_hl = tab_icon(tabpage)
  local click = "%" .. index .. "T"
  local text_hl = selected and "UserTablineTextSel" or "UserTablineText"
  local parts = { click }
  local indicator = selected and hl("UserTablineSeparator", "▍") or hl(text_hl, " ")

  parts[#parts + 1] = indicator
  parts[#parts + 1] = hl(text_hl, " ")

  if icon ~= "" then
    parts[#parts + 1] = hl(icon_hl or text_hl, icon)
    parts[#parts + 1] = hl(text_hl, " ")
  end

  parts[#parts + 1] = hl(text_hl, title)
  parts[#parts + 1] = modified_indicator(tabpage)
  parts[#parts + 1] = hl(text_hl, " ")
  parts[#parts + 1] = "%T"

  return concat(parts)
end

local function build()
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tabpage = vim.api.nvim_get_current_tabpage()
  local max_width = label_budget(#tabpages)
  local parts = {}

  for index, tabpage in ipairs(tabpages) do
    parts[#parts + 1] = render_tab(index, tabpage, current_tabpage, max_width)
  end

  parts[#parts + 1] = "%#UserTablineFill#%="

  return concat(parts)
end

M.build = build

set_highlights()
vim.o.tabline = [[%!v:lua.require("config.ui.tabline").build()]]

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    set_highlights()
    vim.cmd.redrawtabline()
  end,
})

return M
