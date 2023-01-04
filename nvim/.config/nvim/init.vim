" plugins {{{ "
scriptencoding utf-8

let g:mapleader = "\<Space>"

lua <<EOF
require("user.lazy")
require("user.filetype")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("user.autocommands")
    require("user.commands")
    require("user.diagnostics")
  end,
})
EOF
" }}} plugins "

" config {{{ "
set autoindent
set autoread
set autowriteall
set background=dark
set backspace=indent,eol,start
set breakindent
" set cmdheight=0
set completeopt=menu,menuone,noselect
set conceallevel=0
set cursorline  " Highlight current line (slow)
set diffopt+=hiddenoff
set diffopt+=vertical
set expandtab
set fillchars+=diff:╱
set formatoptions-=ro  " Don't insert comment leader on new line
set hidden
set hlsearch
set ignorecase
set inccommand=split
set incsearch
set laststatus=2 " statusline mode
set lazyredraw  " Try to not draw while doing macros (helps with scrolling performance)
set linespace=2
set listchars=tab:>-,trail:-,nbsp:+,eol:$
set magic
set mouse=a
set nobackup
set noruler
set noshowmode
set nostartofline
set noswapfile
set nowritebackup
set number
set relativenumber
set scrolloff=7
set shiftwidth=2
set shortmess-=S
set showmatch
set signcolumn=yes
set smartcase
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set updatetime=200
set undofile
set virtualedit=block
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set wildignorecase
set wildmenu
set wildmode=full
let &showbreak = '└ '
let @/ = ''  " don't show search highlights when entering or resourcing vimrc

if exists('g:neovide')
  set guifont=FiraCode\ Nerd\ Font\ Mono:h18
  inoremap <D-v> "+p<CR>
endif

let g:markdown_fenced_languages = [
  \ 'bash',
  \ 'css',
  \ 'erb=eruby',
  \ 'gql=graphql',
  \ 'graphql',
  \ 'html',
  \ 'javascript',
  \ 'js=javascript',
  \ 'json=javascript',
  \ 'py=python',
  \ 'python',
  \ 'rb=ruby',
  \ 'ruby',
  \ 'sass',
  \ 'sh=bash',
  \ 'ts=typescript',
  \ 'typescript',
  \ 'xml',
\ ]

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

" Buffer config
augroup buffer_config
  autocmd!

  " Autosave on focus lost
  autocmd FocusLost * silent! wall
  autocmd BufLeave  * silent! wall

  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup end

" disable unused providers
let g:loaded_perl_provider = 0

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

" Jump to next match with TAB during a search
set wildcharm=<c-z>
cnoremap <expr> <tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <s-tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<s-tab>"

" QOL remappings
cnoremap %h <c-r>=fnameescape(expand('%:h')).'/'<cr>
cnoremap %t <c-r>=fnameescape(expand('%:t'))<cr>
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
nnoremap <silent> <down>  :cnext<cr>
nnoremap <silent> <left>  :lprevious<cr>
nnoremap <silent> <right> :lnext<cr>
nnoremap <silent> <up>    :cprevious<cr>
nnoremap <silent> <leader><down>  :cnfile<cr>
nnoremap <silent> <leader><left>  :lpfile<cr>
nnoremap <silent> <leader><right> :lnfile<cr>
nnoremap <silent> <leader><up>    :cpfile<cr>
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
nnoremap <silent> <leader>x :wqa<cr>
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G
nnoremap & g&
nnoremap +c :cd %:p:h<cr>
nnoremap M <c-w>o
nnoremap U :undolist<cr>:undo<space>
nnoremap Y y$

nmap ' `
xmap ' `
nnoremap <silent> <leader><cr> :noh<cr>
xnoremap <silent> <leader><cr> :noh<cr>
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

" substitute {{{ "
nnoremap s <Nop>
xnoremap s <Nop>

nnoremap ss :%s/\v//g<left><left><left>

nnoremap <silent> s :set operatorfunc=SubstituteOperator<cr>g@
xnoremap s :<c-u>call SubstituteOperator(visualmode())<cr>

function! SubstituteOperator(type)
  if a:type ==# 'v'
    let isSameLine = getpos("'<")[1] - getpos("'>")[1] == 0

    if isSameLine
      let saved_unnamed_register = @@
      execute 'normal! `<v`>y'
      call feedkeys(':%s/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
      let @@ = saved_unnamed_register
    else
      call feedkeys(":'<,'>s/\\v//g\<left>\<left>\<left>", 't')
    endif
  elseif a:type ==# 'V'
    call feedkeys(":'<,'>s/\\v//g\<left>\<left>\<left>", 't')
  elseif a:type ==# 'char'
    let saved_unnamed_register = @@
    execute 'normal! `[v`]y'
    call feedkeys(':%s/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
    let @@ = saved_unnamed_register
  elseif a:type ==# 'line'
    call feedkeys(":'[,']s/\\v//g\<left>\<left>\<left>", 't')
  else
    echo 'TODO: ' . a:type . ' substitute mode'
    return
  endif
endfunction
" }}} substitute "

" global command {{{ "
nnoremap +g :g//<left>
nnoremap +v :v//<left>

xnoremap +g :g//<left>
xnoremap +v :v//<left>
" }}} global command "

" folds {{{ "
set nofoldenable
"
" augroup folds
"   autocmd!
"
"   " Pre-set the folds to indent but allow for manual folds
"   autocmd BufReadPre  * setlocal foldmethod=indent
"   autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup end
" }}} folds "

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
nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprevious<cr>
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

" sorting {{{ "
function! SortLinesOpFunc(...)
  '[,']sort
endfunction

function! SortReverseLinesOpFunc(...)
  '[,']sort!
endfunction

" nnoremap <silent> gs :<c-u>set operatorfunc=SortLinesOpFunc<cr>g@
" xnoremap <silent> gs :sort<cr>
nnoremap <silent> gr :<c-u>set operatorfunc=SortReverseLinesOpFunc<cr>g@
xnoremap <silent> gr :sort!<cr>
" }}} sorting "

" grep {{{ "
command! -nargs=+ -complete=file Grep silent! grep! -R <args>|botright cwindow|redraw!

nnoremap <leader>F  :Grep ""<left>
xmap     <leader>F *:<c-u>Grep "<c-r>""

nmap <silent> K *:Grep "\b<cword>\b"<cr>
xmap <silent> K *:Grep -F "<c-r>""<cr>
" }}} grep "

" ripgrep {{{ "
if executable('rg')
  command! -nargs=+ -complete=file Grep silent! grep! <args>|botright cwindow|redraw!

  set grepprg=rg\ --hidden\ --vimgrep\ --smart-case\ -g\ '!sorbet'\ -g\ '!Session.vim'
  set grepformat=%f:%l:%c:%m
endif
" }}} ripgrep "

" config editing {{{ "
nnoremap <leader>u <nop>
nnoremap <leader>us :so $MYVIMRC<cr>:echo 'vimrc sourced'<cr>

nnoremap <silent> <leader>ua :e! ~/.zsh/aliases.zsh<cr>
nnoremap <silent> <leader>uh :sp $MYVIMRC<cr>
nnoremap <silent> <leader>um :e! $DOTFILES/vim/.vimrc<cr>
nnoremap <silent> <leader>ur :e! .projections.json<cr>
nnoremap <silent> <leader>ut :e! $DOTFILES/tmux/.config/tmux/tmux.conf<cr>
nnoremap <silent> <leader>uu :e! $MYVIMRC<cr>
nnoremap <silent> <leader>uv :vs $MYVIMRC<cr>
nnoremap <silent> <leader>uw :e! $ZDOTDIR/local/work.zsh<cr>
nnoremap <silent> <leader>uz :e! $ZDOTDIR/.zshrc<cr>
" }}} config editing "

" duplicate file {{{ "
nnoremap <leader>W :saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>
" }}} duplicate file "

" vim-unimpaired {{{ "
nnoremap yo, :set number! relativenumber! cursorline!<cr>

nnoremap yoc :set cursorline!<cr>
nnoremap yod :<c-r>=&diff ? "diffoff" : "diffthis"<cr><cr>
nnoremap yoh :set hlsearch!<cr>
nnoremap yol :set list!<cr>
nnoremap yon :set number!<cr>
nnoremap yop :set paste!<cr>
nnoremap yor :set relativenumber!<cr>

nnoremap yos :setlocal spell! spelllang=en_us<cr>
nnoremap yow :setlocal wrap!<cr>
" }}} vim-unimpaired "

" open resource {{{ "
nnoremap <silent> ¡¡  :silent execute '!open ' . escape(expand('<cWORD>'), '#')<cr>
xnoremap <silent> ¡  y:silent execute '!open ' . escape(getreg('0'), '#')<cr>

nnoremap ¡<space> :!open<space>
" }}} open resource "

" Highlights {{{ "
nnoremap ++ :execute "hi " . synIDattr(synID(line("."),col("."),1),"name")<CR>
nnoremap +<cr> :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap +<space> :hi<space>

hi CursorLineNr guifg=#b8b8b8 guibg=none    cterm=none gui=bold
hi LineNr       guifg=#585858

hi StatusLine   guifg=#d8d8d8 guibg=#212326 cterm=none
hi StatusLineNC guifg=#b8b8b8 guibg=#212326 cterm=none

hi VertSplit    guifg=#212326 guibg=#212326 cterm=none
hi FloatBorder  guifg=#585858

hi GitGutterAdd          guifg=#a1b56c guibg=none cterm=none
hi GitGutterChange       guifg=#7cafc2 guibg=none cterm=none
hi GitGutterChangeDelete guifg=#ba8baf guibg=none cterm=none
hi GitGutterDelete       guifg=#ab4642 guibg=none cterm=none

hi DiffAdd     guifg=#a1b56c guibg=none
hi DiffAdded   guifg=#a1b56c guibg=none
hi DiffChange  guifg=#585858 guibg=none
hi DiffDelete  guifg=#ab4642 guibg=none gui=bold
hi DiffRemoved guifg=#ab4642 guibg=none gui=bold
hi DiffText    guifg=#7cafc2 guibg=none gui=bold
" }}} Highlights "

" redir {{{ "
"
" Examples:
"   :Redir hi
"   :Redir !ls -al
"
"   :.Redir !node  " Evaluate current line in interpreter
"
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor

  if a:cmd =~? '^!'
    let cmd = a:cmd =~? ' %'
          \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
          \ : matchstr(a:cmd, '^!\zs.*')

    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . ' <<< $' . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif

  vnew

  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile

  call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

nnoremap _ :Redir<space>
xnoremap _ :Redir<space>!
" }}} redir "

" notes {{{ "
nnoremap <leader>n :execute "e $NOTES/" . strftime('%F') . ".md"<cr>
" }}} notes "

" jq {{{ "
nnoremap +j :%!jq ''<left>
" }}} jq "

" commands {{{ "
" Git {{{ "
nnoremap <leader>gcb   :Gcb<space>
nnoremap <leader>gcm   :Gcm<cr>
nnoremap <leader>gcq   :Gcq<cr>
nnoremap <leader>gpsup :Gpsup<cr>

command! -nargs=0 Grev  %bdelete <bar> next! `git files` <bar> bd #

command! -nargs=0 Gcm   !git checkout master
command! -nargs=0 Gcq   !git checkout qa
command! -nargs=0 Gpsup !git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
command! -nargs=0 Grhh  !git reset --hard
command! -nargs=1 Gcb   !git checkout -b <args>
" }}} Git "

" QuickFix toggle {{{ "
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()

  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "' . a:bufname . '"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx . 'close')
      return
    endif
  endfor

  if a:pfx ==? 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo 'Location List is empty'
    return
  endif

  let winnr = winnr()
  exec('botright ' . a:pfx . 'open')

  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> ç :call ToggleList("Quickfix List", 'c')<cr>
nnoremap <silent> Ç :call ToggleList("Location List", 'l')<cr>
" }}} QuickFix toggle "

" REMember {{{ "
command! -nargs=0 REMember %s/\(\s\)\([-+]\?\d*\.\?\d*px\)/\1REMember(\2)/g
" }}} REMember "
" }}} commands "
