-- :h statusline
--
-- Each status line item is of the form (only item is required):
--   %-0{minwid}.{maxwid}{item}

-- When it starts with `%!` then it's evaluated as an expression:
--   set statusline=%!MyStatusLine()

-- local winbar = "%*  %#DevIconLua#  %#Winbar#%t ●%*%*"
-- %*  Restore normal highlight
-- %#Highlight#
-- %t  Filename (tail)

local devicons = require("nvim-web-devicons")
local icons_by_filename = devicons.get_icons_by_filename()
local icons_by_extension = devicons.get_icons_by_extension()

local get_highlight_name = function(data)
  return "DevIcon" .. data.name
end

local set_up_highlight = function(icon_data)
  local hl_group = get_highlight_name(icon_data)

  if hl_group and (icon_data.color or icon_data.cterm_color) then
    vim.api.nvim_set_hl(0, get_highlight_name(icon_data), {
      fg = icon_data.color,
      ctermfg = tonumber(icon_data.cterm_color),
    })
  end
end

---@return string, string, string
local get_icon = function()
  local path = vim.fn.bufname()
  local filetype = string.lower(vim.fn.fnamemodify(path, ":t"))
  local ext = vim.fn.fnamemodify(path, ":e")

  if vim.bo.filetype == "" then
    return "", "WinbarNC", "%t"
  elseif vim.bo.filetype == "blame" then
    return "", "WinbarNC", "git blame"
  elseif vim.bo.filetype == "fugitive" then
    return "", "WinbarNC", "fugitive"
  elseif vim.fn.isdirectory(path) > 0 then
    return "", "Directory", "%t"
  elseif path:match("^oil://") then
    local dir = vim.fn.fnamemodify(require("oil").get_current_dir() or "", ":~")
    return "", "Directory", dir
  end

  local icon = icons_by_filename[filetype] or icons_by_extension[ext]

  if not icon then
    return "", "", "%t"
  end

  set_up_highlight(icon)
  return icon.icon, get_highlight_name(icon), "%t"
end

---@return string
local get_winbar = function(opts)
  -- Section A: %#DevIconLua#
  local icon, hl, title = get_icon()
  if not opts.active then
    hl = "WinbarNC"
  end

  local sectionA = "%#" .. hl .. "#" .. icon

  -- Section B: %#Winbar#%t
  if opts.active then
    hl = "Winbar"
  else
    hl = "WinbarNC"
  end

  local sectionB = " " .. "%#" .. hl .. "#" .. title

  local sectionC = ""
  if vim.api.nvim_get_option_value("mod", {}) then
    sectionC = " %#diffAdded#●"
  end

  return "    %*" .. sectionA .. sectionB .. sectionC .. "%*"
end

local events = { "VimEnter", "BufEnter", "BufModifiedSet", "WinEnter", "WinLeave" }
local augroup = vim.api.nvim_create_augroup("user_winbar", { clear = true })
local filetype_exclude = {
  "neo-tree",
  "toggleterm",
  "qf",
}

vim.api.nvim_create_autocmd(events, {
  group = augroup,
  callback = function(args)
    if vim.tbl_contains(filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = nil
      return
    end

    local win_number = vim.api.nvim_get_current_win()
    local win_config = vim.api.nvim_win_get_config(win_number)

    if win_config.relative == "" then
      vim.opt_local.winbar = get_winbar({ active = args.event ~= "WinLeave" })
    else
      vim.opt_local.winbar = nil
    end
  end,
})
