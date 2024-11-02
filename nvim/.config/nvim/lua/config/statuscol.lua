-- From: https://github.com/Wansmer/nvim-config/blob/76075092cf6a595f58d6150bb488b8b19f5d625a/lua/modules/status/components.lua
local M = {}

local u = require("config.utils")

---To display the `number` in the `statuscolumn` according to
---the `number` and `relativenumber` options and their combinations
function M.line_number()
  local nu = vim.opt.number:get()
  local rnu = vim.opt.relativenumber:get()
  local cur_line = vim.fn.line(".") == vim.v.lnum and vim.v.lnum or vim.v.relnum

  -- Repeats the behavior for `vim.opt.numberwidth`
  local numberwidth = vim.opt.numberwidth:get() - 1 -- `numberwidth` includes right padding
  local line_count_width = #tostring(vim.api.nvim_buf_line_count(0))
  -- If buffer have more lines than `vim.opt.numberwidth` then use width of line count
  local width = numberwidth >= line_count_width and numberwidth or line_count_width

  local function pad_start(n)
    local len = width - #tostring(n)
    return len < 1 and n or (" "):rep(len) .. n
  end

  -- Apply highlights to lines in Visual mode
  local visual_highlight = ""
  local mode = vim.fn.strtrans(vim.fn.mode()):lower():gsub("%W", "")

  if mode == "v" then
    local v_range = u.get_visual_range()
    local is_in_range = vim.v.lnum >= v_range[1] and vim.v.lnum <= v_range[3]
    visual_highlight = is_in_range and "%#VisualLineNr#" or ""
  end

  if nu and rnu then
    return visual_highlight .. pad_start(cur_line)
  elseif nu then
    return visual_highlight .. pad_start(vim.v.lnum)
  elseif rnu then
    return visual_highlight .. pad_start(vim.v.relnum)
  end

  return ""
end

---To display pretty fold's icons in `statuscolumn` and show it according to `fillchars`
function M.foldcolumn()
  if not vim.g.foldcolumn then
    return ""
  end

  local chars = vim.opt.fillchars:get()
  local fc = "%#FoldColumn#"
  local clf = "%#CursorLineFold#"
  local hl = vim.fn.line(".") == vim.v.lnum and clf or fc
  local text = " "

  if vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
    if vim.fn.foldclosed(vim.v.lnum) == -1 then
      text = hl .. (chars.foldopen or " ")
    else
      text = hl .. (chars.foldclose or " ")
    end
  elseif vim.fn.foldlevel(vim.v.lnum) == 0 then
    text = hl .. " "
  else
    text = hl .. (chars.foldsep or " ")
  end

  return text
end

---See :h 'statuscolumn'
local statuscolumn = {
  { "%s" }, -- Sign column
  { "%=", M.line_number }, -- %= means "right aligned"
  { M.foldcolumn },
  { " " },
}

---Join statuscolumn sections into a string
---@param sections table
---@return string
local function join_sections(sections)
  local res = ""

  for _, section in ipairs(sections) do
    for _, component in ipairs(section) do
      res = type(component) == "string" and res .. component or res .. component()
    end
  end

  return res
end

---Build string for `statuscolumn`
---@return string
function M.build()
  return vim.v.virtnum ~= 0 and "" or join_sections(statuscolumn)
end

---Return value for `statuscolumn`
---@return string
function M.statuscolumn()
  return '%{%v:lua.require("config.statuscol").build()%}'
end

return M
