scriptencoding utf-8

lua <<EOF
vim.g.mapleader = " "

require("config.filetype")
require("config.lazy") -- load plugins

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config")
  end,
})
EOF

" config {{{ "
" Terminal config
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal norelativenumber signcolumn=no nonumber

tnoremap <c-h> <c-\><c-n><C-w>h
tnoremap <c-j> <c-\><c-n><C-w>j
tnoremap <c-k> <c-\><c-n><C-w>k
tnoremap <c-l> <c-\><c-n><C-w>l
tnoremap kj    <c-\><c-n>
tnoremap KJ    <c-\><c-n>
tnoremap Kj    <c-\><c-n>

" Understand Sorbet files
augroup rbi
  autocmd!
  autocmd BufNewFile,BufRead *.rbi set filetype=ruby
augroup end
" }}} config "

" bindings {{{ "
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>

" Some expansions
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;

" inoremap (<cr> (<cr>)<esc>O
" inoremap [<cr> [<cr>]<esc>O
" inoremap {<cr> {<cr>}<esc>O
"
" inoremap (,<cr> (<cr>),<esc>O
" inoremap [,<cr> [<cr>],<esc>O
" inoremap {,<cr> {<cr>},<esc>O
"
" inoremap (<space> ()<left>
" inoremap [<space> [<space><space>]<left><left>
" inoremap {<space> {<space><space>}<left><left>
"
" inoremap (,<space> (),<left><left>
" inoremap [,<space> [<space><space>],<left><left><left>
" inoremap {,<space> {<space><space>},<left><left><left>

" Jump to next match with TAB during a search
set wildcharm=<c-z>
cnoremap <expr> <tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <s-tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<s-tab>"

" QOL remappings
" cnoremap <silent> %h <c-r>=fnameescape(expand('%:h')).'/'<cr>
" cnoremap <silent> %t <c-r>=fnameescape(expand('%:t'))<cr>
cnoremap <c-a> <c-b>
cnoremap <c-b> <Nop>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <m-left> <s-left>
cnoremap <m-right> <s-right>
cnoremap <m-+> ]
cnoremap <m-ç> }
cnoremap <m-ñ> ~

inoremap <m-left> <s-left>
inoremap <m-right> <s-right>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-O> <esc>O
inoremap <m-o> <esc>o
inoremap <m-+> ]
inoremap <m-ç> }
inoremap <m-ñ> ~

nmap     <s-down> ]c
nmap     <s-up>   [c
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <leader>. @:
nnoremap <leader>, @@
nnoremap <leader>E :e<space><c-r>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>e :e<space>
nnoremap <m-O> mzO<esc>`z
nnoremap <m-o> mzo<esc>`z
nnoremap Ø     mzO<esc>`z
nnoremap ø     mzo<esc>`z
nnoremap <silent> +c :cd %:p:h<cr>
nnoremap <silent> +q :tabonly<cr>
nnoremap <silent> <down>  :cnext<cr>
nnoremap <silent> <left>  :lprevious<cr>
nnoremap <silent> <right> :lnext<cr>
nnoremap <silent> <up>    :cprevious<cr>
nnoremap <silent> <leader><down>  :cnfile<cr>
nnoremap <silent> <leader><left>  :lpfile<cr>
nnoremap <silent> <leader><right> :lnfile<cr>
nnoremap <silent> <leader><up>    :cpfile<cr>
nnoremap <silent> <leader>0 <c-w>=
nnoremap <silent> <leader>= <c-w>=
nnoremap <silent> <leader>C :tabclose<cr>
nnoremap <silent> <leader>Q :%bdelete\|e#\|bd#<cr>
nnoremap <silent> <leader>T :tabnew<cr>
nnoremap <silent> <leader>X :qa!<cr>
nnoremap <silent> <leader>\| <c-w>\|
nnoremap <silent> <leader>_ <c-w>_
nnoremap <silent> <leader>b gg=G
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>m <c-w>_<c-w>\|
nnoremap <silent> <leader>q :%bdelete<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>x :confirm qa<cr>
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G
nnoremap & g&
nnoremap M <c-w>o
nnoremap Y y$

nmap ' `
xmap ' `
" nnoremap <silent> <leader>ñ :noh<cr>
" xnoremap <silent> <leader>ñ :noh<cr>
nnoremap H g^
onoremap H g^
xnoremap H g^
nnoremap L g$
onoremap L g$
xnoremap L g$
nnoremap Q @q
xnoremap <silent> Q :norm @q<cr>
nnoremap ñ /
xnoremap ñ /
nnoremap Ñ ?
xnoremap Ñ ?

" pasting with indent {{{ "
nnoremap <silent> p p:execute ":silent normal! `[v`]="<cr>
nnoremap <silent> P P:execute ":silent normal! `[v`]="<cr>
nnoremap gp p
nnoremap gP P
" }}} pasting with indent "

" select last inserted text {{{ "
nnoremap gV `[v`]
" }}} select last inserted text "

" replace {{{ "
nnoremap R ciw<c-r>0<esc>
xnoremap R "0p
" }}} replace "

" repeat on visual {{{ "
xnoremap <silent> . :normal .<cr>
" }}} repeat on visual "

" indent {{{ "
xnoremap < <gv
xnoremap > >gv
" }}} indent "

" start search {{{ "
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<cr>\>'<bar>set hls<cr>
nnoremap # #N

xnoremap * y:let @/=escape(@@, '/\') <bar> normal! /<cr>
xnoremap # y:let @/=escape(@@, '/\') <bar> normal! ?<cr>
" }}} start search "

" root {{{ "
command! W w !sudo tee % > /dev/null
" }}} root "

" clipboard {{{ "
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
xnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>D "+D
xnoremap <leader>d "+d
" }}} clipboard "

" move line {{{ "
nnoremap <silent> <M-j> :m+<cr>==
nnoremap <silent> <M-k> :m-2<cr>==
xnoremap <silent> <M-j> :m'>+<cr>`<my`>mzgv=gv`yo`z
xnoremap <silent> <M-k> :m'<-2<cr>`>my`<mzgv=gv`yo`z
" }}} move line "

" buffers {{{ "
nnoremap <BS> <C-^>
" nnoremap <silent> <tab> :bnext<cr>
" nnoremap <silent> <s-tab> :bprevious<cr>
nnoremap <silent> <leader>t :enew<cr>
" }}} buffers "

" fix c-i after mapping tab {{{ "
nnoremap <c-e> <c-i>
" }}} fix c-i after mapping tab "

" tags {{{ "
nmap T g]
nmap t <c-]>
" }}} tags "

" splits {{{ "
nnoremap <leader>v <c-w>v
nnoremap <leader>h <c-w>s

nnoremap <leader>H <c-w>H
nnoremap <leader>J <c-w>J
nnoremap <leader>K <c-w>K
nnoremap <leader>L <c-w>L
" }}} splits "

" config editing {{{ "
nnoremap <leader>u <nop>
nnoremap <silent> <leader>us :so $MYVIMRC<cr>:echo 'vimrc sourced'<cr>

nnoremap <silent> <leader>ua :e! $FDOTDIR/aliases.zsh<cr>
nnoremap <silent> <leader>uh :sp $MYVIMRC<cr>
nnoremap <silent> <leader>um :e! $DOTFILES/vim/.vimrc<cr>
nnoremap <silent> <leader>ur :e! .projections.json<cr>
nnoremap <silent> <leader>ut :e! $DOTFILES/tmux/.config/tmux/tmux.conf<cr>
nnoremap <silent> <leader>uu :e! $MYVIMRC<cr>
nnoremap <silent> <leader>uv :vs $MYVIMRC<cr>
nnoremap <silent> <leader>uw :e! $FDOTDIR/local/work.fish<cr>
nnoremap <silent> <leader>uz :e! $FDOTDIR/config.fish<cr>
" }}} config editing "

" duplicate file {{{ "
nnoremap <leader>W :saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>
" }}} duplicate file "

" vim-unimpaired {{{ "
nnoremap <silent> yo, :set number! relativenumber! cursorline!<cr>

nnoremap <silent> yoc :set cursorline!<cr>
nnoremap <silent> yod :<c-r>=&diff ? "diffoff" : "diffthis"<cr><cr>
nnoremap <silent> yoh :set hlsearch!<cr>
nnoremap <silent> yol :set list!<cr>
nnoremap <silent> yon :set number!<cr>
nnoremap <silent> yop :set paste!<cr>
nnoremap <silent> yor :set relativenumber!<cr>

nnoremap <silent> yos :setlocal spell! spelllang=en_us<cr>
nnoremap <silent> yow :setlocal wrap!<cr>
" }}} vim-unimpaired "

" open resource {{{ "
nnoremap <silent> ¡¡  :silent execute '!open ' . escape(expand('<cWORD>'), '#')<cr>
xnoremap <silent> ¡  y:silent execute '!open ' . escape(getreg('0'), '#')<cr>

nnoremap ¡<space> :!open<space>
" }}} open resource "

" Highlights {{{ "
" TODO: Change to vim.show_pos() in nvim 0.9.0
nnoremap <leader>ui :execute "hi " . synIDattr(synID(line("."),col("."),1),"name")<CR>
nnoremap +<cr> :so $VIMRUNTIME/syntax/hitest.vim<cr>
" }}} Highlights "

" notes {{{ "
nnoremap <silent> <leader>n :execute "e $NOTES/" . strftime('%F') . ".md"<cr>
" }}} notes "
