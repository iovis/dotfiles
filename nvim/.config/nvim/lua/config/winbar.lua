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
  ["gitsigns-blame"] = {
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
  undotree = {
    icon = "󰁯",
    hl = "DevIconBackup",
    title = "undotree",
  },
}

---@param path string
---@return WinbarComponent
local function winbar_per_path(path)
  local filename = string.lower(vim.fn.fnamemodify(path, ":t"))
  local ext = vim.fn.fnamemodify(path, ":e")

  local icon, highlight = devicons.get_icon(filename, ext)

  if not icon then
    icon, highlight = devicons.get_icon_by_filetype(vim.bo.filetype, {
      default = true,
      strict = true,
    })
  end

  local title
  if vim.g.winbar_full_path then
    title = path
  else
    title = "%t"
  end

  -- If fugitive object, append the hash to the filename
  if path:match("^fugitive://") then
    -- Parse commit hash (Lua doesn't have fixed number of character patterns {40})
    -- fugitive:///Users/david/.dotfiles/.git//e1e0416a90c20f0181eb3445a3fa98ff9a9b2752/nvim/.config/nvim/lua/config/winbar.lua
    local hash = path:match("%.git/+([^/]+)/")

    if hash then
      hash = hash:sub(1, 8)
      title = ("%s:%s"):format(title, hash)
    end
  end

  return {
    hl = highlight,
    icon = icon,
    title = title,
  }
end

---Calculate winbar string
---@param is_active boolean
---@return string
local function get_winbar(is_active)
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

local ignored_filetypes = {
  "html.kulala_ui",
  "json.kulala_ui",
  "kulala_verbose_result.kulala_ui",
  "text.kulala_ui",
}

local function set_winbar(args)
  -- Ignore custom winbar or certain filetypes
  if vim.wo.winbar:match("»") or vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
    return
  end

  local winnr = vim.api.nvim_get_current_win()
  local win_config = vim.api.nvim_win_get_config(winnr)

  -- Ignore floating windows
  if win_config.relative ~= "" then
    return
  end

  local is_active = args.event ~= "WinLeave"

  -- This still fails for some reason saying it doesn't have enough space
  pcall(vim.api.nvim_set_option_value, "winbar", get_winbar(is_active), {
    scope = "local",
    win = winnr,
  })
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
  callback = set_winbar,
})

vim.g.winbar_full_path = false
vim.keymap.set("n", "yoe", function()
  vim.g.winbar_full_path = not vim.g.winbar_full_path
  set_winbar({})
end, { desc = "Toggle full path in winbar" })
