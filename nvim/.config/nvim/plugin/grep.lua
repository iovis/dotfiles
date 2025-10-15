local u = require("config.utils")

if u.is_executable("rg") then
  vim.o.grepprg =
    "rg --hidden --vimgrep --smart-case -g '!Session.vim' -g '!.git' -g '!.gitattributes' -g '!node_modules'"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.api.nvim_create_user_command("Grep", function(opts)
  vim.cmd("silent grep! " .. opts.args)
  vim.cmd("botright cwindow")
end, { nargs = "+", complete = "file" })

local function escape_for_rg(text)
  -- test string: ();[!]{}/\@<>&#$%?+.*=^~
  -- # and % need to be escaped twice
  return vim.fn.escape(vim.fn.escape(vim.fn.trim(vim.fn.getreg('"')), "%#'\\"), "%#")
end

local function capture_visual_selection()
  local saved_unnamed_register = vim.fn.getreg("@")

  vim.cmd("normal *")
  local search_term = escape_for_rg(vim.fn.getreg("@"))
  vim.fn.setreg("@", saved_unnamed_register)

  return search_term
end

vim.keymap.set("n", "g<space>", ":Grep -F<space>")
vim.keymap.set("x", "g<space>", function()
  if vim.fn.mode() ~= "v" then
    return
  end

  local search_term = capture_visual_selection()
  if search_term == "" then
    return
  end

  u.send_keys(([[:Grep -Fe '%s'<space>]]):format(search_term))
end)

vim.keymap.set("n", "K", "*:Grep -w <cword><cr>", { silent = true, remap = true })
vim.keymap.set("x", "K", function()
  if vim.fn.mode() ~= "v" then
    u.send_keys("k")
    return
  end

  local search_term = capture_visual_selection()
  if search_term == "" then
    return
  end

  vim.cmd.Grep(([[-Fe '%s']]):format(search_term))
end)

vim.keymap.set("n", "<leader>fw", function()
  local cmd = "Grep -w <cword>"

  -- Filter by filetype
  if vim.bo.filetype then
    cmd = ("%s -t %s"):format(cmd, vim.bo.filetype)
  end

  -- Highlight word
  vim.fn.setreg("/", vim.fn.expand("<cword>"))
  vim.cmd("set hlsearch")

  local ok, error = pcall(vim.cmd, cmd)

  if not ok then
    vim.notify(error, vim.log.levels.ERROR)
  end
end, { desc = "Find word in current filetype" })

vim.keymap.set("x", "<leader>fw", function()
  local search_term = capture_visual_selection()

  local cmd = ("Grep -Fe '%s'"):format(search_term)

  -- Filter by filetype
  if vim.bo.filetype then
    cmd = ("%s -t %s"):format(cmd, vim.bo.filetype)
  end

  vim.cmd(cmd)
end, { desc = "Find word in current filetype" })
