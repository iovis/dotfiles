---- Disable Space to not conflict with Leader
vim.keymap.set("n", "<Space>", "<Nop>")

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

---- Command mode
-- " cnoremap <silent> %h <c-r>=fnameescape(expand('%:h')).'/'<cr>
-- " cnoremap <silent> %t <c-r>=fnameescape(expand('%:t'))<cr>

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
-- Movement
vim.keymap.set({ "n", "x" }, "j", "(v:count == 0 ? 'gj' : 'j')", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "(v:count == 0 ? 'gk' : 'k')", { expr = true })

vim.keymap.set({ "n", "x", "o" }, "H", "g^")
vim.keymap.set({ "n", "x", "o" }, "L", "g$")
vim.keymap.set({ "n", "x", "o" }, "'", "`")

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

-- Search
vim.keymap.set({ "n", "x" }, "ñ", "/")
vim.keymap.set({ "n", "x" }, "Ñ", "?")

vim.keymap.set({ "n", "x" }, "<leader>ñ", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "*", [[:let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>]], { silent = true })
vim.keymap.set("x", "*", [[y:let @/= '\V' . escape(@@, '/\') <bar> normal! /<cr>]], { silent = true })

-- Paste
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "p", [[p<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "P", [[P<cmd>execute ":silent normal! `[v`]="<cr>]])
vim.keymap.set("n", "gp", "p")
vim.keymap.set("n", "gP", "P")

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set({ "n", "x" }, "<leader>d", '"+d')
vim.keymap.set("n", "<leader>D", '"+d$')

-- Repeat
vim.keymap.set("x", ".", ":normal .<cr>")

-- Replace
vim.keymap.set("n", "R", "ciw<c-r>0<esc>")
vim.keymap.set("x", "R", '"0p')

-- Macros
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("x", "Q", ":norm @q<cr>", { silent = true })

-- Indent in visual mode
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Tags
vim.keymap.set("n", "t", "<c-]>")
vim.keymap.set("n", "T", "g]")

-- Highlights
vim.keymap.set("n", "+<cr>", "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>")

----------------------------------------------

vim.keymap.set("n", "+t", "<c-w>T")
vim.keymap.set("n", "<leader>P", ":lua =")

---- Quick File access (TODO: do I need this anymore?)
vim.keymap.set("n", "<leader>u", "<nop>")

vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
vim.keymap.set("n", "<leader>uu", "<cmd>e! $MYVIMRC<cr>")

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

---- Setting toggles
vim.keymap.set("n", "yo", "<cmd>set number! relativenumber! cursorline!<cr>")

vim.keymap.set("n", "yoc", "<cmd>set cursorline!<cr>")
vim.keymap.set("n", "yod", ":<c-r>=&diff ? 'diffoff' : 'diffthis'<cr><cr>")
vim.keymap.set("n", "yoh", "<cmd>set hlsearch!<cr>")
vim.keymap.set("n", "yol", "<cmd>set list!<cr>")
vim.keymap.set("n", "yon", "<cmd>set number!<cr>")
vim.keymap.set("n", "yop", "<cmd>set paste!<cr>")
vim.keymap.set("n", "yor", "<cmd>set relativenumber!<cr>")

vim.keymap.set("n", "yos", "<cmd>setlocal spell! spelllang=en_us<cr>")
vim.keymap.set("n", "yow", "<cmd>setlocal wrap!<cr>")

---- Quick `R`
vim.keymap.set("n", "_", ":R lua=")

---- Notes
vim.keymap.set("n", "<leader>n", ":e notes/index.md<cr>", { silent = true })
vim.keymap.set("n", "<leader>N", [[:execute "e notes/" . strftime('%F') . ".md"<cr>]], { silent = true })

---- Global substitutions
vim.keymap.set({ "n", "x" }, "+g", ":g//<left>")
vim.keymap.set({ "n", "x" }, "+l", ':luado return string.format("%s", line)')
vim.keymap.set({ "n", "x" }, "+v", ":v//<left>")

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

---- Terminal mode
vim.keymap.set("t", "kj", [[<c-\><c-n>]])

vim.keymap.set("t", "<c-h>", [[<c-\><c-n><C-w>h]])
vim.keymap.set("t", "<c-j>", [[<c-\><c-n><C-w>j]])
vim.keymap.set("t", "<c-k>", [[<c-\><c-n><C-w>k]])
vim.keymap.set("t", "<c-l>", [[<c-\><c-n><C-w>l]])
