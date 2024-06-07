local devicons = require("nvim-web-devicons")

---@class (exact) WinbarComponent
---@field icon string
---@field hl string Highlight
---@field title string|fun(): string

---@type WinbarComponent
local none = { icon = "", hl = "", title = "" }
local empty = { icon = "", hl = "", title = "" }

---@type table<string, WinbarComponent>
local winbar_per_filetype = {
  DiffviewFiles = empty,
  DiffviewFileHistory = none,
  ["neo-tree"] = empty,
  qf = none,
  toggleterm = none,
  blame = {
    icon = "",
    hl = "DevIconGitLogo",
    title = "git blame",
  },
  checkhealth = {
    icon = "󰓙",
    hl = "DevIconCheckhealth",
    title = "checkhealth",
  },
  fugitive = {
    icon = "",
    hl = "DevIconGitLogo",
    title = "git status",
  },
  fugitiveblame = {
    icon = "",
    hl = "DevIconGitLogo",
    title = "git blame",
  },
  gitrebase = {
    icon = "",
    hl = "DevIconGitLogo",
    title = "git rebase",
  },
  oil = {
    icon = "  ",
    hl = "Directory",
    title = function()
      return vim.fn.fnamemodify(require("oil").get_current_dir() or "", ":~")
    end,
  },
}

---@param path string
---@return WinbarComponent
local winbar_per_path = function(path)
  local filename = string.lower(vim.fn.fnamemodify(path, ":t"))
  local ext = vim.fn.fnamemodify(path, ":e")

  local icon, highlight = devicons.get_icon(filename, ext)

  if not icon then
    icon, highlight = devicons.get_icon_by_filetype(vim.bo.filetype, {
      default = true,
      strict = true,
    })
  end

  return {
    icon = icon,
    hl = highlight,
    title = "%t",
  }
end

---Calculate winbar string
---@param is_active boolean
---@return string
local get_winbar = function(is_active)
  local modified = ""
  if vim.api.nvim_get_option_value("mod", {}) then
    modified = " %#diffAdded#●"
  end

  local winbar = winbar_per_filetype[vim.bo.filetype]

  if not winbar then
    winbar = winbar_per_path(vim.fn.bufname())
  elseif winbar == none then
    return ""
  end

  local title = ""
  if type(winbar.title) == "function" then
    title = winbar.title() --[[@as string]]
  else
    title = winbar.title --[[@as string]]
  end

  if is_active then
    --      "    %#DevIconLua# %#Winbar#%t %#diffAdded#●"
    return ("    %%#%s#%s %%#Winbar#%s%s"):format(winbar.hl, winbar.icon, title, modified)
  else
    --      "    %#WinbarNC# %t %#diffAdded#●"
    return ("    %%#WinbarNC#%s %s%s"):format(winbar.icon, title, modified)
  end
end

local augroup = vim.api.nvim_create_augroup("user_winbar", { clear = true })
local events = {
  "VimEnter",
  "BufEnter",
  "BufModifiedSet",
  "WinEnter",
  "WinLeave",
}

vim.api.nvim_create_autocmd(events, {
  group = augroup,
  callback = function(args)
    -- Ignore custom winbar
    if vim.wo.winbar:match("»") then
      return
    end

    -- Ignore floating windows
    local winnr = vim.api.nvim_get_current_win()
    local win_config = vim.api.nvim_win_get_config(winnr)
    if win_config.relative ~= "" then
      return
    end

    local is_active = args.event ~= "WinLeave"

    vim.wo.winbar = get_winbar(is_active)
  end,
})
