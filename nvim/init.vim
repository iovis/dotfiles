" plugins {{{ "
scriptencoding utf-8
filetype off

lua require('plugins')
" }}} plugins "

" config {{{ "
filetype plugin indent on

set autoindent
set autoread
set autowriteall
set background=dark
set backspace=indent,eol,start   " Fix backspace not deleting tabs, also make delimiteMate work
set breakindent
set completeopt-=preview
set conceallevel=0
set cursorline  " Highlight current line (slow as fuck)
set diffopt+=hiddenoff
set diffopt+=vertical
set expandtab
set formatoptions-=ro  " Don't insert comment leader on new line
set hidden    " remember undo after quitting
set hlsearch
set ignorecase
set inccommand=split
set incsearch
set laststatus=2
set lazyredraw  " Try to not draw while doing macros (helps with scrolling performance)
set linespace=2
set listchars=tab:>-,trail:-,nbsp:+,eol:$
set magic
set mouse=a
set nobackup
set noruler
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
set termguicolors
set updatetime=300
set undofile
set undodir=~/.config/nvim/undo
set virtualedit=block
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set wildignorecase
set wildmenu
set wildmode=full
let &showbreak = '└ '
let @/ = ""  " don't show search highlights when entering or resourcing vimrc

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
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
" }}} config "

" bindings {{{ "
inoremap kj <Esc>
let g:mapleader = "\<Space>"
nnoremap <space> <nop>
xnoremap <space> <nop>

" Some expansions
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;

" Jump to next match with TAB during a search
set wildcharm=<c-z>
cnoremap <expr> <tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <s-tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<s-tab>"

" QOL remappings
cnoremap <c-a> <c-b>
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
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>q :%bdelete<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>x :wqa<cr>
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G
nnoremap +c :cd %:p:h<cr>
nnoremap M <c-w>o
nnoremap Q @q
nnoremap U :undolist<cr>:undo<space>
nnoremap Y y$
nnoremap Ñ ?
nnoremap ñ /
noremap ' `
noremap <silent> <leader><cr> :noh<cr>
noremap H g^
noremap L g$
xnoremap <silent> Q :norm @q<cr>
xnoremap Ñ ?
xnoremap ñ /

" buffer closing {{{ "
" Don't close if there are changes (toggle removing split or not)
nnoremap <silent> º :Bdelete<cr>
nnoremap <silent> <leader>º :bdelete<cr>

" Close even if there are changes (toggle removing the split)
nnoremap <silent> ª :Bdelete!<cr>
nnoremap <silent> <leader>ª :bdelete!<cr>
" }}} buffer closing "
" }}} bindings "

" Map pending
" nnoremap &

" substitute {{{ "
nnoremap s <Nop>
xnoremap s <Nop>

nnoremap ss :%s///g<left><left><left>

nnoremap <silent> s :set operatorfunc=SubstituteOperator<cr>g@
xnoremap s :<c-u>call SubstituteOperator(visualmode())<cr>

function! SubstituteOperator(type)
  if a:type ==? 'v'
    let isSameLine = getpos("'<")[1] - getpos("'>")[1] == 0

    if isSameLine
      let saved_unnamed_register = @@
      execute 'normal! `<v`>y'
      call feedkeys(':%s/' . escape(@@, '/\') . "//g\<left>\<left>", 't')
      let @@ = saved_unnamed_register
    else
      call feedkeys(":'<,'>s///g\<left>\<left>\<left>", 't')
    endif
  elseif a:type ==# 'char'
    let saved_unnamed_register = @@
    execute 'normal! `[v`]y'
    call feedkeys(':%s/' . escape(@@, '/\') . "//g\<left>\<left>", 't')
    let @@ = saved_unnamed_register
  elseif a:type ==# 'line'
    call feedkeys(":'[,']s///g\<left>\<left>\<left>", 't')
  else
    echo 'TODO: ' . a:type . ' substitute mode'
    return
  endif
endfunction
" }}} substitute "

" global command {{{ "
nnoremap +g :g//<left>
nnoremap +v :v//<left>

xnoremap +g y:g/<c-r>=escape(@",'/\')<cr>/
xnoremap +v y:v/<c-r>=escape(@",'/\')<cr>/
" }}} global command "

" folds {{{ "
set nofoldenable

augroup folds
  autocmd!

  " Pre-set the folds to indent but allow for manual folds
  autocmd BufReadPre  * setlocal foldmethod=indent
  autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup end
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
nnoremap <silent> ¶ :m+<cr>==
nnoremap <silent> § :m-2<cr>==
xnoremap <silent> ¶ :m'>+<cr>`<my`>mzgv=gv`yo`z
xnoremap <silent> § :m'<-2<cr>`>my`<mzgv=gv`yo`z
" }}} move line "

" buffers {{{ "
nmap <leader><leader> :ls<cr>

nnoremap <BS> <C-^>
nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprevious<cr>
nnoremap <silent> <leader>t :enew<cr>
" }}} buffers "

" fix c-i after mapping tab {{{ "
nnoremap <c-e> <c-i>
" }}} fix c-i after mapping tab "

" splits {{{ "
nnoremap <leader>v <c-w>v
nnoremap <leader>h <c-w>s
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

  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
" }}} ripgrep "

" config editing {{{ "
nnoremap <leader>u <nop>
nnoremap <leader>us :so $MYVIMRC<cr>:echo 'vimrc sourced'<cr>

nnoremap <silent> <leader>ua :e! ~/.zsh/aliases.zsh<cr>
nnoremap <silent> <leader>uf :execute empty(&filetype) ? 'echo "no filetype specified"' : 'EditFtplugin'<cr>
nnoremap <silent> <leader>uh :sp $MYVIMRC<cr>
nnoremap <silent> <leader>um :e! ~/.dotfiles/.vimrc<cr>
nnoremap <silent> <leader>up :e! ~/.config/nvim/lua/plugins.lua<cr>
nnoremap <silent> <leader>ur :e! .projections.json<cr>
nnoremap <silent> <leader>ut :e! ~/.tmux.conf<cr>
nnoremap <silent> <leader>uu :e! $MYVIMRC<cr>
nnoremap <silent> <leader>uv :vs $MYVIMRC<cr>
nnoremap <silent> <leader>uw :e! ~/.zsh/work.zsh<cr>
nnoremap <silent> <leader>uz :e! ~/.zshrc<cr>

command! -nargs=? -complete=filetype EditFtplugin
      \ exe 'keepjumps e! $HOME/.config/nvim/after/ftplugin/' . (empty(<q-args>) ? &filetype : <q-args>) . '.vim'
" }}} config editing "

" duplicate file {{{ "
nnoremap <leader>W :saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>
" }}} duplicate file "

" vim-unimpaired {{{ "
nnoremap yo, :set number! relativenumber! cursorline!<cr>
nnoremap yo; :set relativenumber! cursorline!<cr>
nnoremap yoc :setlocal cursorline!<cr>
nnoremap yod :<c-r>=&diff ? "diffoff" : "diffthis"<cr><cr>
nnoremap yol :setlocal list!<cr>
nnoremap yon :setlocal number!<cr>
nnoremap yop :setlocal paste!<cr>
nnoremap yor :setlocal relativenumber!<cr>
nnoremap yos :setlocal spell! spelllang=en_us<cr>
nnoremap yow :setlocal wrap!<cr>
" }}} vim-unimpaired "

" open resource {{{ "
nnoremap <silent> ¡¡  :execute '!open ' . escape(expand('<cWORD>'), '#')<cr>
xnoremap <silent> ¡  y:execute '!open ' . escape(getreg('0'), '#')<cr>

nnoremap ¡<space> :!open<space>
" }}} open resource "

" Highlights {{{ "
nnoremap ++ :execute "hi " . synIDattr(synID(line("."),col("."),1),"name")<CR>
nnoremap +<cr> :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap +<space> :hi<space>

hi HighlightedyankRegion ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE

augroup highlighted_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup="HighlightedyankRegion", timeout=500 }
augroup END
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

" CCR {{{ "
" Present an action for every command that returns a list
" https://gist.github.com/romainl/5b2cfb2b81f02d44e1d90b74ef555e31
function! CCR()
  let cmdline = getcmdline()

  command! -bar Z silent set more|delcommand Z

  if getcmdtype() != ':'
    return "\<CR>"
  endif

  if cmdline =~ '\v\C^(ls|files|buffers)'
    " like :ls but prompts for a buffer command
    return "\<CR>:b\<space>"
  elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
    " like :g//# but prompts for a command
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    " like :dlist or :ilist but prompts for a count for :djump or :ijump
    return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    " like :oldfiles but prompts for an old file to edit
    set nomore
    return "\<CR>:Z|e #<"
  elseif cmdline =~ '\C^changes'
    " like :changes but prompts for a change to jump to
    set nomore
    return "\<CR>:Z|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    " like :jumps but prompts for a position to jump to
    set nomore
    return "\<CR>:Z|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    " like :marks but prompts for a mark to jump to
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    " like :undolist but prompts for a change to undo
    return "\<CR>:u "
  elseif cmdline =~ '\C^reg'
    " Added by me!
    return "\<CR>:norm \"p\<Left>"
  else
    return "\<CR>"
  endif
endfunction

cnoremap <expr> <CR> CCR()
" }}} CCR "

" registers {{{ "
nmap +r :registers<cr>
" }}} registers "

" marks {{{ "
nmap +m :marks<cr>
" }}} marks "

" jq {{{ "
nnoremap +j :%!jq ''<left>
" }}} jq "

" plugin configuration {{{ "
" autoformat {{{ "
nnoremap <silent> <leader>b :Autoformat<cr>
xnoremap <silent> <leader>b :Autoformat<cr>

let g:autoformat_verbosemode = 0
let g:formatters_javascript = ['prettier']
let g:formatters_json = ['prettier']
let g:formatters_ruby = ['rubocop']
" }}} autoformat "

" base16 {{{ "
lua << EOF
local base16 = require('base16')

base16(base16.themes["default-dark"], true)
EOF
" }}} base16 "

" browsers_castle {{{ "
nnoremap g<space>  :Google<space>
nnoremap g<cr>     :Google <c-r><c-w><cr>
xnoremap g<space> y:Google <c-r>"
xnoremap g<cr>    y:Google <c-r>"<cr>

nnoremap <silent> <leader>< :execute 'Canary ' . DotenvGet('PROJECT_URL')<cr>
" }}} browsers_castle "

" bufonly {{{ "
nnoremap <silent> <leader>Q :BufOnly!<cr>
" }}} bufonly "

" coc.nvim {{{ "
let g:coc_global_extensions = [
\ 'coc-css',
\ 'coc-html',
\ 'coc-json',
\ 'coc-pyright',
\ 'coc-rust-analyzer',
\ 'coc-sh',
\ 'coc-snippets',
\ 'coc-solargraph',
\ 'coc-tsserver',
\ 'coc-yaml'
\ ]

inoremap <silent><expr> <c-b> coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nmap <silent> <c-t> <Plug>(coc-type-definition)
nmap <silent> t     <Plug>(coc-definition)
nmap <silent> T     <Plug>(coc-references)
nmap <silent> gR    <Plug>(coc-rename)

nnoremap <silent> <leader>lR :CocList -I symbols<cr>
nnoremap <silent> <leader>lc :CocList commands<cr>
nnoremap <silent> <leader>le :CocList --normal extensions<cr>
nnoremap <silent> <leader>lr :CocList outline<cr>
nnoremap <silent> <leader>uc :CocConfig<cr>
nnoremap <silent> gd :call <SID>show_documentation()<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
hi default CocHighlightText gui=underline
" augroup coc
"   autocmd!
"   autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup END

" coc-snippets
imap <c-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> <leader>ls :CocList snippets<cr>
nnoremap <silent> <leader>ue :CocCommand snippets.editSnippets<cr>
nnoremap <silent> <leader>ss :CocCommand snippets.openSnippetFiles<cr>
" }}} coc.nvim "

" csv {{{ "
hi CSVColumnEven ctermbg=242 guibg=#6C6C6C
hi CSVColumnOdd  term=NONE   ctermbg=NONE
" }}} csv "

" dadbod {{{ "
nnoremap d!       :DB w:db =<space>
nnoremap d<cr>    :execute 'Start pgcli ' . CurrentDB()<cr>
nnoremap d<space> :DB<space>
nnoremap d?       :echo CurrentDB()<cr>

function! CurrentDB()
  return exists('w:db') ? w:db : DotenvGet('DATABASE_URL')
endf
" }}} dadbod "

" delimitmate {{{ "
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" }}} delimitmate "

" dispatch {{{ "
nnoremap s<cr>    :Dispatch<cr>
nnoremap s<space> :Dispatch<space>
nnoremap s!       :Dispatch!<cr>
nnoremap s?       :FocusDispatch<cr>
" }}} dispatch "

" echodoc {{{ "
let g:echodoc_enable_at_startup = 1

set cmdheight=2
set noshowmode
" }}} echodoc "

" emmet {{{ "
let g:user_emmet_leader_key = '<c-s>'
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \    'extends' : 'jsx',
      \  },
      \}
" }}} emmet "

" fugitive {{{ "
nmap <silent> <leader>- :Gedit:<cr>)

nnoremap <leader>gm :Git mergetool<cr>
nnoremap <leader>go :Gread<cr>

nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <silent> <leader>gg :GBrowse<cr>

nnoremap <silent> <leader>gh :Glol %<cr>
nnoremap <silent> <leader>gl :Glol -500<cr>

xnoremap <silent> <leader>gg :GBrowse<cr>
xnoremap <silent> <leader>gh :GLogL<cr>

nnoremap <silent> <leader>gdv :Gvdiffsplit<cr>
nnoremap <silent> <leader>gdh :Ghdiffsplit<cr>
nnoremap <silent> <leader>gdm :Gdiffsplit master<cr>

nnoremap <leader>gprq :Git hub pull-request --push --browse -m '' --edit -a iovis -b qa -l 'Needs Review'
nnoremap <leader>gprm :Git hub pull-request --push --browse -m '' --edit -a iovis -b master -l 'Waiting for QA'

command! -nargs=* Glol Git log --graph --pretty='%h -%d %s (%cr) <%an>' <args>
command! -range -nargs=* GLogL Git log -L <line1>,<line2>:% <args>
" }}} fugitive "

" fzf-lua {{{ "
lua <<EOF
local tnoremap = function(lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, "t", lhs, rhs, { silent = true, noremap = true })
end

local original_fd_opts = require('fzf-lua.config').globals.files.fd_opts

require('fzf-lua').setup {
  winopts = {
    window_on_create = function()
      tnoremap("<c-j>", "<down>")
      tnoremap("<c-k>", "<up>")
      tnoremap("<m-left>", "<s-left>")
      tnoremap("<m-right>", "<s-right>")
      tnoremap("<m-+>", "]")
      tnoremap("<m-ç>", "}")
      tnoremap("<m-ñ>", "~")
    end
  },
  keymap = {
    builtin = {
      ["º"]    = "toggle-preview",
      ["<F1>"] = "preview-page-reset",
      -- defaults (overridden otherwise)
      ["<F2>"] = "toggle-fullscreen",
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
    }
  },
  files = {
    fd_opts = original_fd_opts .. [[ --no-ignore --exclude '.keep']]
  },
  git = {
    icons = {
      ["?"] = { icon = "?", color = "magenta" },
      ["A"] = { icon = "+", color = "green" },
      ["D"] = { icon = "✗", color = "red" },
      ["M"] = { icon = "★", color = "yellow" },
      ["R"] = { icon = "➜", color = "yellow" },
    },
  },
  grep = {
    -- Don't search on the filename, just the content
    fzf_opts = {
      ['--delimiter'] = ':',
      ['--nth'] = '4..',
    }
  }
}
EOF

nnoremap +s :FzfLua<space>

nnoremap <silent> +f :FzfLua live_grep<cr>
nnoremap <silent> +m :FzfLua marks<cr>
nnoremap <silent> +r :FzfLua registers<cr>
nnoremap <silent> <c-p> :FzfLua commands<cr>
nnoremap <silent> <leader><leader> :FzfLua buffers<cr>
nnoremap <silent> <leader>A   :FzfLua filetypes<cr>
nnoremap <silent> <leader>H   :FzfLua git_bcommits<cr>
nnoremap <silent> <leader>O   :FzfLua files<cr>
nnoremap <silent> <leader>R   :FzfLua tags<cr>
nnoremap <silent> <leader>f   :FzfLua grep<cr><cr>
nnoremap <silent> <leader>gL  :FzfLua git_commits<cr>
nnoremap <silent> <leader>gco :FzfLua git_branches<cr>
nnoremap <silent> <leader>j   :FzfLua git_status<cr>
nnoremap <silent> <leader>o   :FzfLua git_files<cr>
nnoremap <silent> <leader>r   :FzfLua btags<cr>
nnoremap <silent> <leader>ñ   :FzfLua blines<cr>
xnoremap <silent> <leader>f   :<c-u>FzfLua grep_visual<cr>
" }}} fzf-lua "

" gitsigns {{{ "
nnoremap <silent> +q :Gitsigns toggle_current_line_blame<cr>

lua <<EOF
require('gitsigns').setup {
  keymaps = {},
  current_line_blame_opts = {
    delay = 100,
  }
}

vim.api.nvim_set_keymap(
  'n',
  ']c',
  "&diff ? ']c' : '<cmd>lua require(\"gitsigns.actions\").next_hunk()<CR>'",
  { noremap = true, expr = true }
)

vim.api.nvim_set_keymap(
  'n',
  '[c',
  "&diff ? '[c' : '<cmd>lua require(\"gitsigns.actions\").prev_hunk()<CR>'",
  { noremap = true, expr = true }
)
EOF
" }}} gitsigns "

" hubcap.vim {{{ "
" nnoremap <leader>gco  :Gco<space>
nnoremap <leader>gprb :Gprb<cr>
nnoremap <leader>gprc :Gprc<space>
nnoremap <leader>gprs :Gprs<cr>:Gprc<space>
" }}} hubcap.vim "

" jirafa {{{ "
let g:jira_url = $JIRA_URL
nnoremap <silent> <leader>J :Jira<cr>
" }}} jirafa "

" jsx {{{ "
let g:jsx_ext_required = 0
" }}} jsx "

" lion {{{ "
let b:lion_squeeze_spaces = 1

nmap <leader>a, mzgLip,'z
nmap <leader>a: mzgLip:'z
nmap <leader>a= mzglip='z
nmap <leader>aB mzglip{'z
" }}} lion "

" lualine {{{ "
lua <<EOF
require('plenary.reload').reload_module('lualine', true)
require('lualine').setup {
  options = {
    theme = 'jellybeans'
  },
  extensions = { 'fugitive', 'nvim-tree', 'quickfix', 'fzf' }
}
EOF
" }}} lualine "

" neomake {{{ "
call neomake#configure#automake('nwr', 1000)

let g:neomake_error_sign   = { 'text': '●', 'texthl': 'NeomakeErrorSign' }
let g:neomake_info_sign    = { 'text': '●', 'texthl': 'NeomakeInfoSign' }
let g:neomake_message_sign = { 'text': '●', 'texthl': 'NeomakeMessageSign' }
let g:neomake_warning_sign = { 'text': '●', 'texthl': 'NeomakeWarningSign' }

let g:neomake_html_enabled_makers = ['htmlhint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_markers = ['python3', 'pylint']
let g:neomake_python_flake8_args = ['--ignore', 'E402,E501']
let g:neomake_python_pylint_args = ['--disable', 'C0114,E501']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_yaml_yamllint_args = ['-f', 'parsable']

if executable($PWD . '/node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_exe = $PWD . '/node_modules/.bin/eslint'
endif
" }}} neomake "

" netrw {{{ "
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'
" let g:netrw_list_hide = '^.*\.o/\=$,^.*\.obj/\=$,^.*\.bak/\=$,^.*\.exe/\=$,^.*\.py[co]/\=$,^.*\.swp/\=$,^.*\~/\=$,^.*\.pyc/\=$,^\.svn/\=$,^\.\.\=/\=$'
let g:netrw_liststyle = 3
let g:netrw_silent = 1
let g:netrw_sort_options = 'i'
" let g:netrw_sort_sequence = '[\/]$,*,\%(\.bak\|\~\|\.o\|\.h\|\.info\|\.swp\|\.obj\)[*@]\=$'
let g:netrw_special_syntax = 1
let g:netrw_winsize = 25

nnoremap <silent> <leader>k :Lexplore<cr>

augroup netrw_commands
  autocmd!
  autocmd FileType netrw nnoremap <buffer> <c-l> <c-w>l
  autocmd FileType netrw nmap     <buffer> <c-r> <Plug>NetrwRefresh
augroup END
" }}} netrw "

" nvim-bufferline {{{ "
nnoremap <silent> <tab>   :BufferLineCycleNext<cr>
nnoremap <silent> <s-tab> :BufferLineCyclePrev<cr>

nnoremap <silent> +be :BufferLineSortByExtension<cr>
nnoremap <silent> +bd :BufferLineSortByDirectory<cr>

lua <<EOF
require('bufferline').setup {
  highlights = {
    indicator_selected = {
      guifg = {
        attribute = "bg",
        highlight = "HighlightedyankRegion",
      }
    }
  },
  options = {
    numbers = function(opts)
      return string.format('%s.', opts.ordinal)
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { "", "" },
    offsets = {
      {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center"
      },
      {
          filetype = "undotree",
          text = "Undo Tree",
          highlight = "Directory",
          text_align = "center"
      }
      }
  }
}

-- nnoremap <silent> <leader>1 <cmd>BufferLineGoToBuffer 1<cr>
for i = 1, 9 do
  vim.api.nvim_set_keymap(
    "n",
    "<leader>" .. i,
    ':lua require("bufferline").go_to_buffer(' .. i .. ")<CR>",
    { silent = true, nowait = true, noremap = true }
  )
end
EOF
" }}} nvim-bufferline "

" nvim-bqf {{{ "
lua <<EOF
require('bqf').setup({
  filter = {
    fzf = {
      extra_opts = { '--bind', 'ctrl-p:page-down,ctrl-n:page-up,alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all' }
    }
  }
})
EOF
" }}} nvim-bqf "

" nvim-tree {{{ "
nnoremap <leader>k :NvimTreeToggle<cr>
nnoremap - :NvimTreeFindFile<cr>

lua <<EOF
local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {
  disable_netrw = false,
  filters = {
    custom = {
      '*.pyc',
      '.DS_Store',
      '.bundle',
      '.git',
      '.github',
      '.vscode',
      '.yardoc',
      'Session.vim',
      'node_modules',
      'tags'
    }
  },
  view = {
    -- These don't seem to work yet
    -- winopts = {
    --   relativenumber = true,
    --   signcolumn = 'no',
    -- },
    mappings = {
      list = {
        { key = "x", cb = tree_cb("close_node") },
        { key = "C", cb = tree_cb("cd") },
        { key = "D", cb = tree_cb("cut") },
        { key = "J", cb = tree_cb("next_sibling") },
        { key = "K", cb = tree_cb("prev_sibling") },
      }
    }
  }
}

vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_width = 35

local nvim_tree_view = require('nvim-tree.view').View
nvim_tree_view.winopts.relativenumber = true
nvim_tree_view.winopts.signcolumn = 'no'
EOF
" }}} nvim-tree "

" obsession {{{ "
nnoremap yoo :Obsession<cr>
" }}} obsession "

" projectionist {{{ "
nnoremap <silent> <leader>aa :A<cr>
nnoremap <silent> <leader>ah :AS<cr>
nnoremap <silent> <leader>av :AV<cr>
nnoremap <silent> <leader>ar :R<cr>

nnoremap <silent> <leader>S :Start!<cr>
" }}} projectionist "

" peekaboo {{{ "
let g:peekaboo_delay = 750
" }}} peekaboo "

" resize.vim {{{ "
nmap <m-up>    <Plug>ResizeUp
nmap <m-down>  <Plug>ResizeDown
nmap <m-left>  <Plug>ResizeLeft
nmap <m-right> <Plug>ResizeRight
" }}} resize.vim "

" sneak {{{ "
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1

map f <Plug>Sneak_f
map F <Plug>Sneak_F

xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

hi Sneak      ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
hi SneakScope ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
" }}} sneak "

" scriptease.vim {{{ "
" In ftplugin/vim.vim
" }}} scriptease.vim "

" substitute.vim {{{ "
nnoremap S <Nop>
xnoremap S <Nop>

nnoremap SS :S!///g<left><left><left>

nnoremap <silent> S :set operatorfunc=GlobalSubstituteOperator<cr>g@
" xnoremap S :<c-u>call GlobalSubstituteOperator(visualmode())<cr>

function! GlobalSubstituteOperator(type)
  if a:type ==? 'v'
    let isSameLine = getpos("'<")[1] - getpos("'>")[1] == 0

    if isSameLine
      let saved_unnamed_register = @@
      execute 'normal! `<v`>y'
      call feedkeys(":S!/" . escape(@@, '/\') . "//g\<left>\<left>", 't')
      let @@ = saved_unnamed_register
    else
      call feedkeys(":S!///g\<left>\<left>\<left>", 't')
    endif
  elseif a:type ==# 'char'
    let saved_unnamed_register = @@
    execute 'normal! `[v`]y'
    call feedkeys(':S!/' . escape(@@, '/\') . "//g\<left>\<left>", 't')
    let @@ = saved_unnamed_register
  elseif a:type ==# 'line'
    call feedkeys(":S!///g\<left>\<left>\<left>", 't')
  else
    echo 'TODO: ' . a:type . ' substitute mode'
    return
  endif
endfunction
" }}} substitute.vim "

" targets {{{ "
augroup targets_conf
  autocmd!
  autocmd User targets#mappings#user call targets#mappings#extend({
        \ 'r': { 'pair': [{ 'o': '[', 'c': ']' }]}
        \ })
augroup end
" }}} targets "

" telescope.nvim {{{ "
" nnoremap +s :Telescope<space>

" nnoremap <silent> <c-p> :Telescope commands<cr>
" nnoremap <silent> <leader><leader> :Telescope buffers<cr>
" nnoremap <silent> <leader>A   :Telescope filetypes<cr>
" nnoremap <silent> <leader>H   :Telescope git_bcommits<cr>
" nnoremap <silent> <leader>gL  :Telescope git_commits<cr>
" nnoremap <silent> <leader>R   :Telescope tags<cr>
" nnoremap <silent> <leader>f   :Telescope live_grep<cr>
" nnoremap <silent> <leader>gco :Telescope git_branches<cr>
" nnoremap <silent> <leader>j   :Telescope git_status<cr>
" nnoremap <silent> <leader>o   :Telescope find_files<cr>
" nnoremap <silent> <leader>r   :Telescope treesitter<cr>
" nnoremap <silent> <leader>ñ   :Telescope current_buffer_fuzzy_find<cr>

" nnoremap <silent> +m :Telescope marks<cr>
" nnoremap <silent> +r :Telescope registers<cr>

" lua <<EOF
" local actions = require('telescope.actions')

" require('telescope').setup {
"   defaults = {
"     mappings = {
"       i = {
"         ["<c-u>"] = false,
"         ["<c-j>"] = actions.move_selection_next,
"         ["<c-k>"] = actions.move_selection_previous,
"         ["<esc>"] = actions.close,
"         ["<c-h>"] = "which_key"
"         ["<down>"] = actions.preview_scrolling_down,
"         ["<up>"] = actions.preview_scrolling_up,
"       }
"     }
"   }
" }
" EOF
" }}} telescope.nvim "

" tmux navigator {{{ "
let g:tmux_navigator_save_on_switch = 2
" }}} tmux navigator "

" treesitter {{{ "
" set foldexpr=nvim_treesitter#foldexpr()
" nnoremap +z :setlocal foldmethod=expr<cr>

lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true -- [workaround] Allow for matchit and vim-endwise to work
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-n>",
      node_incremental = "<c-n>",
      scope_incremental = "<c-s>",
      node_decremental = "<c-p>",
    }
  },
  indent = {
    enable = true,
    disable = { "ruby" },
  }
}
EOF
" }}} treesitter "

" tresitter playground {{{ "
nnoremap +h :TSHighlightCapturesUnderCursor<cr>
nnoremap +t :TSPlaygroundToggle<cr>

lua <<EOF
require("nvim-treesitter.configs").setup {
  playground = {
    enable = true
  }
}
EOF
" }}} tresitter playground "

" treesitter textobjects {{{ "
lua <<EOF
require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ad"] = "@block.outer",
        ["id"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["g>"] = "@parameter.inner",
      },
      swap_previous = {
        ["g<"] = "@parameter.inner",
      },
    },
  },
}
EOF
" }}} treesitter textobjects "

" tux.vim {{{ "
nnoremap c<space> :Tux<space>
nnoremap y<space> :Tux!<space>

" Repeat command in last tmux split
nnoremap <silent> <leader>i :Tux Up<cr>

" Execute current line
nnoremap <silent> <leader>I  :silent execute 'Tux ' . getline('.')<cr>
xnoremap <silent> <leader>i y:silent execute 'Tux ' . escape(getreg('0'), '#')<cr>
" }}} tux.vim "

" undotree {{{ "
nnoremap <silent> U :UndotreeToggle<cr>
" }}} undotree "

" vim-test {{{ "
nnoremap <silent> <leader>si :TestNearest<cr>
nnoremap <silent> <leader>so :TestFile<cr>
nnoremap <silent> <leader>sa :TestSuite<cr>
nnoremap <silent> <leader>sl :TestLast<cr>
nnoremap <silent> <leader>sv :TestVisit<cr>

function! TuxStrategy(cmd)
  execute 'Tux ' . a:cmd
endfunction

let g:test#custom_strategies = { 'tux': function('TuxStrategy') }
let g:test#strategy = 'tux'
let g:test#rust#cargotest#test_patterns = {
      \ 'test': ['\v(#\[%(actix_rt::|tokio::|rs)?test)'],
      \ 'namespace': ['\vmod (tests?)']
      \ }

" let test#ruby#use_spring_binstub = 1
" }}} vim-test "

" vimlook {{{ "
nnoremap <leader>¡ :QuickLook<space>
" }}} vimlook "

" ysurround {{{ "
nmap <leader>" mzcs'"`z
nmap <leader>' mzcs"'`z
" }}} ysurround "

" zen-mode {{{ "
nnoremap <silent> <leader>z :ZenMode<cr>

lua << EOF
require("zen-mode").setup {
  window = {
    backdrop = 1,
    height = .9,
    width = .8,
    options = {
      -- Any vim.wo options
      signcolumn = "no",
      number = false,
      relativenumber = false,
    },
  },
}
EOF
" }}} zen-mode "
" }}} plugin configuration "

" commands {{{ "
" Docker {{{ "
nnoremap <leader>dcu :Dcup<cr>
nnoremap <leader>dcp :Dcps<cr>
nnoremap <leader>dcs :Dcstop<cr>

command! Dcup   Dispatch! docker compose up -d --remove-orphans
command! Dcps   Dispatch  docker compose ps
command! Dcstop Dispatch! docker compose stop
" }}} Docker "

" Git {{{ "
nnoremap <leader>gcb   :Gcb<space>
nnoremap <leader>gcm   :Gcm<cr>
nnoremap <leader>gcq   :Gcq<cr>
nnoremap <leader>gpsup :Gpsup<cr>
nnoremap <leader>grhh  :Grhh<cr>

nnoremap <silent> <leader>grr :%bdelete <bar> next! `git files` <bar> bd #<cr>

command! -nargs=0 Gcm   !git checkout master
command! -nargs=0 Gcq   !git checkout qa
command! -nargs=0 Gpsup !git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
command! -nargs=0 Grhh  !git reset --hard
command! -nargs=1 Gcb   !git checkout -b <args>
" }}} Git "

" Hex Mode {{{ "
command! -bar Hexmode call ToggleHex()

function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&modified
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1

  if !exists('b:editHex') || !b:editHex
    " save old options
    let b:oldft=&filetype
    let b:oldbin=&binary

    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries

    "(DOS line endings will be shown entirely )
    let &filetype='xxd'

    " set status
    let b:editHex=1

    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &filetype=b:oldft

    if !b:oldbin
      setlocal nobinary
    endif

    " set status
    let b:editHex=0

    " return to normal editing
    %!xxd -r
  endif
  "
  " restore values for modified and read only state
  let &modified=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
" }}} Hex Mode "

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
