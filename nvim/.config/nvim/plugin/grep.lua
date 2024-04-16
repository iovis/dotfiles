if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --hidden --vimgrep --smart-case -g '!Session.vim' -g '!.git'"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.api.nvim_create_user_command("Grep", function(opts)
  -- NOTE: I tried setting the search based on the command but it's pointless
  --    - The command could have flags, like `-F` (technically doable parsing `opts.fargs`)
  --    - I could be passing something like `<cword>` so good luck with that
  -- vim.fn.setreg("/", opts.args)
  -- vim.print(vim.fn.getreg("/"))

  vim.cmd("silent grep! " .. opts.args)
  vim.cmd("botright cwindow")
end, { nargs = "+", complete = "file" })

-- TODO: There may be a `vim.keymap.set("ca", ...)` in nvim v0.10
vim.cmd([[
  cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
]])

vim.keymap.set("n", "g<space>", ":Grep<space>")
vim.keymap.set("x", "g<space>", [[*:Grep -F <c-r>=shellescape(getreg('"'), 1)<cr><space>]], {
  remap = true,
})

vim.keymap.set("n", "K", "*:Grep -w <cword><cr>", { silent = true, remap = true })
vim.keymap.set("x", "K", "g<space><cr>", { silent = true, remap = true })
