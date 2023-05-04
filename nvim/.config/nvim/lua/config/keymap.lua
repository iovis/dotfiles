---- Insert mode
-- Exit
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "KJ", "<esc>")
vim.keymap.set("i", "Kj", "<esc>")

-- Quick expansions
vim.keymap.set("i", ",,", "<c-o>A,")
vim.keymap.set("i", ";;", "<c-o>A;")

vim.keymap.set("i", "<m-+>", "]")
vim.keymap.set("i", "<m-ç>", "}")
vim.keymap.set("i", "<m-ñ>", "~")

-- Movement
vim.keymap.set("i", "<m-left>", "<s-left>")
vim.keymap.set("i", "<m-right>", "<s-right>")

vim.keymap.set("i", "<c-a>", "<home>")
vim.keymap.set("i", "<c-e>", "<end>")

vim.keymap.set("i", "<m-O>", "<esc>O")
vim.keymap.set("i", "<m-o>", "<esc>o")

---- Terminal mode
vim.keymap.set("t", "kj", [[<c-\><c-n>]])

---- Command mode
-- " cnoremap <silent> %h <c-r>=fnameescape(expand('%:h')).'/'<cr>
-- " cnoremap <silent> %t <c-r>=fnameescape(expand('%:t'))<cr>

-- Fish's binding for edit command in editor
vim.keymap.set("c", "<m-e>", "<c-f>")

-- Quick expansions
vim.keymap.set("c", "<m-+>", "]")
vim.keymap.set("c", "<m-ç>", "}")
vim.keymap.set("c", "<m-ñ>", "~")

-- Movement
vim.keymap.set("c", "<m-left>", "<s-left>")
vim.keymap.set("c", "<m-right>", "<s-right>")

vim.keymap.set("c", "<c-a>", "<c-b>")
vim.keymap.set("c", "<c-b>", "<nop>")

vim.keymap.set("c", "<c-j>", "<down>")
vim.keymap.set("c", "<c-k>", "<up>")

---- Normal mode
-- Buffers
vim.keymap.set("n", "<bs>", "<c-^>")

vim.keymap.set("n", "<leader>t", "<cmd>enew<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>%bdelete<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>%bdelete|e#|bd#<cr>")

vim.keymap.set("n", "<leader>e", ":e<space>")
vim.keymap.set("n", "<leader>E", ":e<space><c-r>=fnameescape(expand('%:h')).'/'<cr>")
vim.keymap.set("n", "<leader>W", ":saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>")

-- Editing
vim.keymap.set("n", "J", "m`J``")

vim.keymap.set("n", "<m-j>", "<cmd>m+<cr>==")
vim.keymap.set("n", "<m-k>", "<cmd>m-2<cr>==")
vim.keymap.set("x", "<m-j>", ":m'>+<cr>`<my`>mzgv=gv`yo`z", { silent = true })
vim.keymap.set("x", "<m-k>", ":m'<-2<cr>`>my`<mzgv=gv`yo`z", { silent = true })

vim.keymap.set("n", "<m-o>", "m`o<esc>``")
vim.keymap.set("n", "<m-O>", "m`O<esc>``")

vim.keymap.set("n", "<leader>b", "gg=G")

vim.keymap.set("n", "g2", "m`:set shiftwidth=2 softtabstop=2 expandtab | retab<cr>gg=G``")
vim.keymap.set("n", "g4", "m`:set shiftwidth=4 softtabstop=4 expandtab | retab<cr>gg=G``")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Editor
vim.keymap.set("n", "+c", ":cd <c-r>=fnameescape(expand('%:p:h'))<cr><cr>")
vim.keymap.set("n", "<leader>x", "<cmd>confirm qa<cr>")
vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>")

-- Macros
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("x", "Q", ":norm @q<cr>", { silent = true })

-- Movement
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

vim.keymap.set({ "n", "x", "o" }, "H", "g^")
vim.keymap.set({ "n", "x", "o" }, "L", "g$")
vim.keymap.set({ "n", "x", "o" }, "'", "`")

vim.keymap.set("n", "<s-up>", "[c", { remap = true })
vim.keymap.set("n", "<s-down>", "]c", { remap = true })

vim.keymap.set("n", "<c-e>", "<c-i>")

-- Open Resource
vim.keymap.set("n", "¡¡", "<cmd>silent execute '!open ' . escape(expand('<cWORD>'), '#')<cr>")
vim.keymap.set("x", "¡", "y<cmd>silent execute '!open ' . escape(getreg('0'), '#')<cr>")

vim.keymap.set("n", "¡<space>", ":!open<space>")

-- Panes
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>h", "<c-w>s")

vim.keymap.set("n", "<leader>c", "<c-w>c")
vim.keymap.set("n", "<leader>0", "<c-w>=")

vim.keymap.set("n", "<leader>H", "<c-w>H")
vim.keymap.set("n", "<leader>J", "<c-w>J")
vim.keymap.set("n", "<leader>K", "<c-w>K")
vim.keymap.set("n", "<leader>L", "<c-w>L")

vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "<leader>m", "<c-w>_<c-w>|")
vim.keymap.set("n", "<leader>_", "<c-w>_")
vim.keymap.set("n", "<leader>|", "<c-w>|")

-- Copy/Paste
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "p", [[p<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "P", [[P<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "gp", "p")
vim.keymap.set("n", "gP", "P")

vim.keymap.set("x", "p", "P") -- don't copy selected text to unnamed register
vim.keymap.set("x", "P", "p")

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set({ "n", "x" }, "<leader>d", '"+d')
vim.keymap.set("n", "<leader>D", '"+d$')

vim.keymap.set("n", "<leader>y<c-g>", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy current buffer's path to clipboard" })

-- Quickfix/Location list
vim.keymap.set("n", "<up>", "<cmd>cprevious<cr>")
vim.keymap.set("n", "<down>", "<cmd>cnext<cr>")

vim.keymap.set("n", "<leader><up>", "<cmd>cpfile<cr>")
vim.keymap.set("n", "<leader><down>", "<cmd>cnfile<cr>")

vim.keymap.set("n", "<left>", "<cmd>lprevious<cr>")
vim.keymap.set("n", "<right>", "<cmd>lnext<cr>")

vim.keymap.set("n", "<leader><left>", "<cmd>lpfile<cr>")
vim.keymap.set("n", "<leader><right>", "<cmd>lnfile<cr>")

-- Repeat
vim.keymap.set("n", "<leader>.", "@:")
vim.keymap.set("n", "<leader>,", "@@")
vim.keymap.set("x", ".", ":normal .<cr>", { silent = true })

-- Replace
vim.keymap.set("n", "R", "ciw<c-r>0<esc>")
vim.keymap.set("x", "R", '"0p')

-- Search
vim.keymap.set({ "n", "x" }, "ñ", "/")
vim.keymap.set({ "n", "x" }, "Ñ", "?")

vim.keymap.set({ "n", "x" }, "<leader>ñ", function()
  vim.cmd.nohlsearch()
  vim.cmd.echon()
end, { desc = "Clear search highlights and command line output" })

vim.keymap.set("n", "*", [[:let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>]], { silent = true })
vim.keymap.set("x", "*", [[y:let @/= '\V' . escape(@@, '/\') <bar> set hls <bar> normal! /<cr>]], { silent = true })

-- Tabs
-- vim.keymap.set("n", "<leader>T", "<cmd>tabnew<cr>") -- TODO: use for autotest preferences?
vim.keymap.set("n", "<leader>n", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>C", "<cmd>tabclose<cr>")
vim.keymap.set("n", "+t", "<c-w>T")
vim.keymap.set("n", "+q", "<cmd>tabonly<cr>")

-- Tags
vim.keymap.set("n", "t", "<c-]>")
vim.keymap.set("n", "T", "g]")

---- Quick File access
vim.keymap.set("n", "<leader>u", "<nop>")

-- Config files
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
vim.keymap.set("n", "<leader>uu", "<cmd>e! $MYVIMRC<cr>")

-- Notes
vim.keymap.set("n", "<leader>un", ":e! notes/index.md<cr>")
vim.keymap.set("n", "<leader>N", function()
  local note = string.format("notes/%s.md", vim.fn.strftime("%F"))
  vim.cmd.edit(note)
end, { desc = "Open daily note" })

-- Project files
vim.keymap.set("n", "<leader>uv", "<cmd>e! .env<cr>")
vim.keymap.set("n", "<leader>uj", "<cmd>e! justfile<cr>")

-- nnoremap <silent> <leader>us :so $MYVIMRC<cr>:echo 'vimrc sourced'<cr>
--
-- nnoremap <silent> <leader>ua :e! $FDOTDIR/aliases.zsh<cr>
-- nnoremap <silent> <leader>uh :sp $MYVIMRC<cr>
-- nnoremap <silent> <leader>um :e! $DOTFILES/vim/.vimrc<cr>
-- nnoremap <silent> <leader>ur :e! .projections.json<cr>
-- nnoremap <silent> <leader>ut :e! $DOTFILES/tmux/.config/tmux/tmux.conf<cr>
-- nnoremap <silent> <leader>uv :vs $MYVIMRC<cr>
-- nnoremap <silent> <leader>uw :e! $FDOTDIR/local/work.fish<cr>
-- nnoremap <silent> <leader>uz :e! $FDOTDIR/config.fish<cr>

---- Toggle Settings
vim.keymap.set("n", "yo,", ":set number! relativenumber! cursorline!<cr>")

vim.keymap.set("n", "yoc", ":set cursorline!<cr>")
vim.keymap.set("n", "yod", ":<c-r>=&diff ? 'diffoff' : 'diffthis'<cr><cr>")
vim.keymap.set("n", "yoh", ":set hlsearch!<cr>")
vim.keymap.set("n", "yol", ":set list!<cr>")
vim.keymap.set("n", "yon", ":set number!<cr>")
vim.keymap.set("n", "yop", ":set paste!<cr>")
vim.keymap.set("n", "yor", ":set relativenumber!<cr>")

vim.keymap.set("n", "yos", ":setlocal spell! spelllang=en_us<cr>")
vim.keymap.set("n", "yow", ":setlocal wrap!<cr>")

---- Misc
vim.keymap.set("n", "<Space>", "<Nop>")
-- vim.keymap.set("n", "q:", ":") -- If you enable this, then you have to wait when finishing macros

vim.keymap.set("n", "+<cr>", "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>")

vim.keymap.set("n", "_", ":R=")
vim.keymap.set("n", "<leader>P", ":=")
vim.keymap.set("n", "<leader>M", "<cmd>R! messages<cr>G")
vim.keymap.set("n", "+M", function()
  print("messages cleared")
  vim.cmd("messages clear")
end, { desc = "Clear messages" })

---- Global substitutions
vim.keymap.set({ "n", "x" }, "+g", ":g//<left>")
vim.keymap.set({ "n", "x" }, "+v", ":v//<left>")
vim.keymap.set({ "n", "x" }, "+l", function()
  return ':luado return string.format("-- %s", line)' .. ("<left>"):rep(10)
end, { expr = true })

---- Tmux quick switching
vim.keymap.set("n", "++", "<cmd>TmuxNewSession<cr>")
vim.keymap.set("n", "+<space>", ":TmuxNewSession<space>")
vim.keymap.set("n", "+V", "<cmd>VimPlugin<cr>")

---- Toggle autoformat
vim.keymap.set("n", "<leader>B", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    print("Autoformat disabled")
  else
    vim.g.autoformat = true
    print("Autoformat enabled")
  end
end, { desc = "Toggle autoformat" })

---- Toggle autotest
vim.keymap.set("n", "+T", function()
  vim.ui.select({ "file", "line", "disable" }, {
    prompt = "RSpec> ",
    format_item = function(item)
      local is_current = ""

      if vim.g.autotest == item or (vim.g.autotest == nil and item == "disable") then
        is_current = " (current)"
      end

      return item .. is_current
    end,
  }, function(choice)
    if choice == "disable" then
      vim.g.autotest = nil
    else
      vim.g.autotest = choice
    end
  end)
end, { desc = "Toggle autotest" })
