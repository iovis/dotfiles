local u = require("config.utils")

if u.is_executable("rg") then
  vim.o.grepprg = "rg --hidden --vimgrep --smart-case -g '!Session.vim' -g '!.git'"
  vim.o.grepformat = "%f:%l:%c:%m"
end

u.cabbrev("Grep")
u.command("Grep", function(opts)
  -- NOTE: I tried setting the search based on the command but it's pointless
  --    - The command could have flags, like `-F` (technically doable parsing `opts.fargs`)
  --    - I could be passing something like `<cword>` so good luck with that
  -- vim.fn.setreg("/", opts.args)
  -- vim.print(vim.fn.getreg("/"))

  vim.cmd("silent grep! " .. opts.args)
  vim.cmd("botright cwindow")
end, { nargs = "+", complete = "file" })

vim.keymap.set("n", "g<space>", ":Grep<space>")
vim.keymap.set("x", "g<space>", [[*:Grep -F <c-r>=shellescape(getreg('"'), 1)<cr><space>]], {
  remap = true,
})

vim.keymap.set("n", "K", "*:Grep -w <cword><cr>", { silent = true, remap = true })
vim.keymap.set("x", "K", "g<space><cr>", { silent = true, remap = true })
