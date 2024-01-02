local title = function(bufnr)
  local file = vim.fn.bufname(bufnr)
  local buftype = vim.fn.getbufvar(bufnr, "&buftype")
  local filetype = vim.fn.getbufvar(bufnr, "&filetype")

  if buftype == "help" then
    return "help:" .. vim.fn.fnamemodify(file, ":t:r")
  elseif buftype == "quickfix" then
    return "quickfix"
  elseif filetype == "TelescopePrompt" then
    return "Telescope"
  elseif filetype == "git" then
    return "Git"
  elseif filetype == "fugitive" then
    return "Fugitive"
  elseif filetype == "fzf" then
    return "FZF"
  elseif buftype == "terminal" then
    local _, match = string.match(file, "term:(.*):(%a+)")
    return match ~= nil and match or vim.fn.fnamemodify(vim.env.SHELL, ":t")
  elseif file == "" then
    return "[No Name]"
  else
    return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
  end
end

local modified = function(bufnr)
  return vim.fn.getbufvar(bufnr, "&modified") == 1 and "[+] " or ""
end

local windowCount = function(index)
  local nwins = 0
  local success, wins = pcall(vim.api.nvim_tabpage_list_wins, index)

  if success then
    for _ in pairs(wins) do
      nwins = nwins + 1
    end
  end

  return nwins > 1 and "(" .. nwins .. ") " or ""
end

local separator = function(index)
  return (index < vim.fn.tabpagenr("$") and "%#TabLine#|" or "")
end

local cell = function(index)
  local isSelected = vim.fn.tabpagenr() == index
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]
  local hl = (isSelected and "%#TabLineSel#" or "%#TabLine#")

  return hl
    .. "%"
    .. index
    .. "T"
    .. " "
    .. windowCount(index)
    .. title(bufnr)
    .. " "
    .. modified(bufnr)
    .. "%T"
    .. separator(index)
end

local tabline = function()
  local line = ""

  for i = 1, vim.fn.tabpagenr("$"), 1 do
    line = line .. cell(i)
  end

  line = line .. "%#TabLineFill#%="

  return line
end

vim.o.tabline = "%!v:lua.require'config.tabline'.tabline()"

return {
  tabline = tabline,
}
