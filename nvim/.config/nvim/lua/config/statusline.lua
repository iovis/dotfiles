local M = {}

local u = require("config.utils")

local augroup = vim.api.nvim_create_augroup("user_statusline", { clear = true })

local function stl_escape(text)
  return tostring(text or ""):gsub("%%", "%%%%")
end

local function hl(group, text)
  if text == "" then
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

local function shorten_path(path, sep, max_len)
  local len = #path
  if len <= max_len then
    return path
  end

  local segments = vim.split(path, sep)
  for idx = 1, #segments - 1 do
    if len <= max_len then
      break
    end

    local segment = segments[idx]
    local shortened = segment:sub(1, vim.startswith(segment, ".") and 2 or 1)
    segments[idx] = shortened
    len = len - (#segment - #shortened)
  end

  return table.concat(segments, sep)
end

local function catppuccin_palette()
  local ok, palette = pcall(function()
    return require("catppuccin.palettes").get_palette()
  end)

  if ok then
    return palette
  end

  return {
    blue = "#8caaee",
    mantle = "#292c3c",
    overlay0 = "#737994",
    peach = "#ef9f76",
  }
end

local function set_highlights()
  local colors = catppuccin_palette()

  vim.api.nvim_set_hl(0, "UserStatuslineA", {
    fg = colors.blue,
    bg = colors.mantle,
  })
  vim.api.nvim_set_hl(0, "UserStatuslineB", {
    fg = colors.overlay0,
  })
  vim.api.nvim_set_hl(0, "UserStatuslineX", {
    fg = colors.peach,
  })
end

local function filename()
  local path_separator = package.config:sub(1, 1)
  local data = vim.fn.expand("%:~:.")

  if data == "" then
    data = "[No Name]"
  else
    local available = vim.go.columns - 40
    if available > 0 then
      data = shorten_path(data, path_separator, available)
    end
  end

  return data
end

local function modified_indicator()
  if not vim.api.nvim_get_option_value("mod", {}) then
    return ""
  end

  return " " .. hl("DiffAdded", "●")
end

local function file_icon()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return "", "UserStatuslineB"
  end

  local icon, highlight = devicons.get_icon(vim.fn.expand("%:t"))
  if not icon then
    icon, highlight = devicons.get_icon_by_filetype(vim.bo.filetype, {
      default = true,
      strict = true,
    })
  end

  if not icon then
    icon = ""
    highlight = "DevIconDefault"
  end

  return icon, highlight or "UserStatuslineB"
end

local function diagnostics()
  local parts = {}
  local defs = {
    { severity = vim.diagnostic.severity.ERROR, icon = "󰅚 ", group = "DiagnosticError" },
    { severity = vim.diagnostic.severity.WARN, icon = "󰀪 ", group = "DiagnosticWarn" },
    { severity = vim.diagnostic.severity.INFO, icon = "󰋽 ", group = "DiagnosticInfo" },
    { severity = vim.diagnostic.severity.HINT, icon = "󰌶 ", group = "DiagnosticHint" },
  }

  for _, item in ipairs(defs) do
    local count = #vim.diagnostic.get(0, { severity = item.severity })
    if count > 0 then
      table.insert(parts, hl(item.group, ("%s%d"):format(item.icon, count)))
    end
  end

  if vim.tbl_isempty(parts) then
    return ""
  end

  return " " .. table.concat(parts, " ")
end

local function muxi_marks()
  local ok, muxi = pcall(require, "muxi")
  if not ok then
    return ""
  end

  local marks = muxi.marks_for_current_file()
  if vim.tbl_isempty(marks) then
    return ""
  end

  table.sort(marks, function(a, b)
    return a.pos[1] < b.pos[1]
  end)

  local keys = vim
    .iter(marks)
    :map(function(mark)
      return mark.key
    end)
    :join(" ")

  return " " .. hl("UserStatuslineX", "[" .. keys .. "]")
end

local function diff_status()
  local diff = vim.b.gitsigns_status_dict
  if type(diff) ~= "table" then
    return ""
  end

  local parts = {}
  local defs = {
    { key = "added", icon = "+", group = "DiffAdded" },
    { key = "modified", fallback = "changed", icon = "~", group = "DiffChanged" },
    { key = "removed", icon = "-", group = "DiffRemoved" },
  }

  for _, item in ipairs(defs) do
    local count = diff[item.key] or (item.fallback and diff[item.fallback]) or 0
    if count > 0 then
      table.insert(parts, hl(item.group, item.icon .. count))
    end
  end

  if vim.tbl_isempty(parts) then
    return ""
  end

  return " " .. table.concat(parts, " ")
end

local function branch_name()
  if type(vim.b.gitsigns_status_dict) == "table" and vim.b.gitsigns_status_dict.head then
    return vim.b.gitsigns_status_dict.head
  end

  if vim.b.gitsigns_head and vim.b.gitsigns_head ~= "" then
    return vim.b.gitsigns_head
  end

  if vim.fn.exists("*FugitiveHead") == 1 then
    local ok, head = pcall(vim.fn.FugitiveHead)
    if ok and head ~= "" then
      return head
    end
  end

  return ""
end

local function branch()
  local head = branch_name()
  if head == "" then
    return ""
  end

  return " " .. hl("UserStatuslineB", u.truncate(" " .. head, 20))
end

local function progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  local percent = math.floor(cur / math.max(total, 1) * 100) .. "%"

  return " " .. hl("UserStatuslineB", ("%5s:%s"):format(percent, total))
end

local function location()
  return hl("UserStatuslineB", (" %3d:%-2d"):format(vim.fn.line("."), vim.fn.charcol(".")))
end

local function quickfix_title()
  local is_loclist = vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
  if is_loclist then
    return vim.fn.getloclist(0, { title = 0 }).title
  end

  local total_pages = vim.fn.getqflist({ nr = "$" }).nr
  local qf = vim.fn.getqflist({ nr = 0, title = 0 })

  return ("[%d/%d] %s"):format(qf.nr, total_pages, qf.title)
end

local function render_default()
  local icon, icon_hl = file_icon()

  return concat({
    hl("UserStatuslineA", " "),
    icon ~= "" and hl(icon_hl, " " .. icon) or "",
    hl("UserStatuslineB", " " .. filename()),
    modified_indicator(),
    diagnostics(),
    "%<%=",
    muxi_marks(),
    diff_status(),
    branch(),
    progress(),
  })
end

local function render_quickfix()
  return concat({
    hl("UserStatuslineA", " "),
    hl("UserStatuslineB", "  " .. quickfix_title()),
    "%<%=",
    diff_status(),
    branch(),
    progress(),
  })
end

local function render_fugitive()
  local branch_label = branch_name()
  if branch_label == "" then
    branch_label = "fugitive"
  else
    branch_label = " " .. branch_label
  end

  return concat({
    hl("UserStatuslineA", " " .. branch_label .. " "),
    "%<%=",
    location(),
  })
end

local function render_lazy()
  local ok_lazy, lazy = pcall(require, "lazy")
  local ok_status, lazy_status = pcall(require, "lazy.status")

  local right = ""
  if ok_lazy then
    right = hl("UserStatuslineB", (" loaded: %d/%d"):format(lazy.stats().loaded, lazy.stats().count))
  end

  local updates = ""
  if ok_status and lazy_status.has_updates() then
    updates = hl("UserStatuslineB", " " .. lazy_status.updates())
  end

  return concat({
    hl("UserStatuslineA", " lazy 💤 "),
    right,
    updates,
  })
end

local function render_mason()
  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    return hl("UserStatuslineA", " Mason ")
  end

  return concat({
    hl("UserStatuslineA", " Mason "),
    hl(
      "UserStatuslineB",
      (" Installed: %d/%d"):format(#registry.get_installed_packages(), #registry.get_all_package_specs())
    ),
  })
end

local function render_oil()
  local ok, oil = pcall(require, "oil")
  if not ok then
    return hl("UserStatuslineA", " oil ")
  end

  local current_dir = oil.get_current_dir() or ""
  local dir = vim.fn.fnamemodify(current_dir, ":~")

  return concat({
    hl("UserStatuslineA", " "),
    hl("Directory", " "),
    hl("UserStatuslineB", " " .. dir),
    "%<%=",
    branch(),
    progress(),
  })
end

local special_renderers = {
  fugitive = render_fugitive,
  lazy = render_lazy,
  mason = render_mason,
  oil = render_oil,
  qf = render_quickfix,
}

local function build_in_window(winid)
  return vim.api.nvim_win_call(winid, function()
    local renderer = special_renderers[vim.bo.filetype] or render_default
    return renderer()
  end)
end

function M.build()
  local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
  local ok, rendered = pcall(build_in_window, winid)

  if ok then
    return rendered
  end

  return ""
end

set_highlights()
vim.g.qf_disable_statusline = true
vim.o.statusline = [[%!v:lua.require("config.statusline").build()]]

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    set_highlights()
    vim.cmd.redrawstatus()
  end,
})

return M
