local u = require("config.utils")

if u.is_executable("rg") then
  vim.o.grepprg = "rg --hidden --vimgrep --smart-case -g '!Session.vim' -g '!.git'"
  vim.o.grepformat = "%f:%l:%c:%m"
end

u.alias_command("Grep")
u.command("Grep", function(opts)
  vim.cmd("silent grep! " .. opts.args)
  vim.cmd("botright cwindow")
end, { nargs = "+", complete = "file" })

vim.keymap.set("n", "g<space>", ":Grep<space>")
vim.keymap.set("x", "g<space>", [[*:Grep -F <c-r>=shellescape(getreg('"'), 1)<cr><space>]], {
  remap = true,
})

vim.keymap.set("n", "K", "*:Grep -w <cword><cr>", { silent = true, remap = true })
vim.keymap.set("x", "K", "g<space><cr>", { silent = true, remap = true })

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
  local saved_unnamed_register = vim.fn.getreg("@")

  vim.cmd("normal! y")
  local query = vim.fn.shellescape(vim.fn.getreg("@"))
  local cmd = ("Grep -F %s"):format(query)

  -- Filter by filetype
  if vim.bo.filetype then
    cmd = ("%s -t %s"):format(cmd, vim.bo.filetype)
  end

  -- Highlight word
  vim.fn.setreg("/", vim.fn.escape(vim.fn.getreg("@"), "/\\$.*^~"))
  vim.cmd("set hlsearch")

  vim.fn.setreg("@", saved_unnamed_register)

  vim.cmd(cmd)
end, { desc = "Find word in current filetype" })
