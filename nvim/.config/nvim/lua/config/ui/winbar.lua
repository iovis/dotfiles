local devicons = require("nvim-web-devicons")
local u = require("config.utils")

---@class (exact) WinbarComponent
---@field icon string
---@field hl string Highlight
---@field title string|fun(): string

---@type WinbarComponent
local none = { icon = "", hl = "", title = "" }
local empty = { icon = "", hl = "", title = "" }

local function winbar_escape(text)
  return tostring(text or ""):gsub("%%", "%%%%")
end

---@type table<string, WinbarComponent>
local winbar_per_filetype = {
  DiffviewFiles = empty,
  DiffviewFileHistory = none,
  ["neo-tree"] = empty,
  qf = none,
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
  ["gitsigns-blame"] = {
    icon = "",
    hl = "DevIconGitLogo",
    title = "git blame",
  },
  help = {
    icon = "󰈙",
    hl = "DevIconLog",
    title = function()
      return "help:" .. vim.fn.fnamemodify(vim.fn.bufname(), ":t:r")
    end,
  },
  ["markdown.gh"] = {
    icon = "",
    title = function()
      return vim.fn.bufname()
    end,
  },
  ["nvim-undotree"] = {
    icon = "󰁯",
    hl = "DevIconBackup",
    title = "%t",
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
local function winbar_per_path(path)
  if vim.bo.buftype == "terminal" then
    return {
      hl = "DevIconAwk",
      icon = "",
      title = winbar_escape(u.terminal_label(0) or "terminal"),
    }
  end

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
    title = vim.fn.fnamemodify(path, ":.")
  else
    title = "%t"
  end

  -- If git object, append the hash to the filename
  if path:match("^fugitive://") or path:match("^gitsigns://") then
    -- Parse commit hash (Lua doesn't have fixed number of character patterns {40})
    -- fugitive:///Users/david/.dotfiles/.git//e1e0416a90c20f0181eb3445a3fa98ff9a9b2752/nvim/.config/nvim/lua/config/winbar.lua
    -- gitsigns:///Users/david/.dotfiles/.git//e1e0416a90c20f0181eb3445a3fa98ff9a9b2752^:nvim/.config/nvim/lua/config/winbar.lua
    local hash = path:match("%.git/+([^/]+)/")

    if hash then
      hash = hash:sub(1, 8)
      title = ("%s [%s]"):format(title, hash)
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
  "snacks_layout_box",
  "snacks_picker_input",
  "snacks_picker_list",
  "text.kulala_ui",
}

---@param winid integer
---@param is_active boolean
local function set_winbar_for_window(winid, is_active)
  vim.api.nvim_win_call(winid, function()
    -- Ignore custom winbar or certain filetypes
    if vim.wo.winbar:match("»") or vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
      return
    end

    local win_config = vim.api.nvim_win_get_config(winid)

    -- Ignore floating windows
    if win_config.relative ~= "" then
      return
    end

    local winbar = get_winbar(is_active)
    if vim.bo.buftype == "terminal" then
      winbar = " " .. vim.trim(winbar)
    end

    -- This still fails for some reason saying it doesn't have enough space
    pcall(vim.api.nvim_set_option_value, "winbar", winbar, {
      scope = "local",
      win = winid,
    })
  end)
end

local function set_winbar(args)
  local winnr = vim.api.nvim_get_current_win()
  local is_active = args.event ~= "WinLeave"
  set_winbar_for_window(winnr, is_active)
end

local function refresh_terminal_winbar(args)
  if not u.is_terminal_title_sequence(args.data and args.data.sequence) then
    return
  end

  local current_window = vim.api.nvim_get_current_win()
  for _, winid in ipairs(vim.fn.win_findbuf(args.buf)) do
    if vim.api.nvim_win_is_valid(winid) then
      local is_active = winid == current_window
      set_winbar_for_window(winid, is_active)
    end
  end
end

local augroup = vim.api.nvim_create_augroup("user_winbar", { clear = true })
local events = {
  "VimEnter",
  "BufEnter",
  "BufModifiedSet",
  "WinEnter",
  "WinLeave",
  "TermOpen",
}

vim.api.nvim_create_autocmd(events, {
  group = augroup,
  callback = set_winbar,
})

vim.api.nvim_create_autocmd("TermRequest", {
  group = augroup,
  callback = refresh_terminal_winbar,
})

vim.keymap.set("n", "yof", function()
  vim.g.winbar_full_path = not vim.g.winbar_full_path
  vim.cmd.redrawtabline()

  local current_window = vim.api.nvim_get_current_win()
  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_is_valid(winid) then
      set_winbar_for_window(winid, winid == current_window)
    end
  end
end, { desc = "Toggle full path in winbar" })
