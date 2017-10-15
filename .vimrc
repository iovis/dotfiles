set nocompatible
filetype off

call plug#begin()

" Add or remove your plugins here:
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chiel92/vim-autoformat'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-pug'
Plug 'elzr/vim-json'
Plug 'honza/vim-snippets'
Plug 'iovis9/vim-searchindex'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'marcweber/vim-addon-mw-utils'  " Required by vim-snippets
Plug 'mattn/emmet-vim'
Plug 'metakirby5/codi.vim'
Plug 'moll/vim-bbye'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/nginx.vim'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'shawncplus/phpcomplete.vim'
Plug 'shougo/vimproc.vim', {'do' : 'make'}
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-lion'
Plug 'tomtom/tlib_vim'                 " Required by vim-snippets
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-characterize'          " Use ga to see additional representations of that character
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'                " Unix helpers (:Move, :Remove...)
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" This one goes after YouCompleteMe so it doesn't
" overload the imap <bs> mapping
Plug 'raimondi/delimitMate'

call plug#end()

" CUSTOM SETTINGS
filetype plugin indent on
colorscheme base16-default-dark

syntax enable
set autoindent
set autoread
set autowriteall
set background=dark
set backspace=indent,eol,start   " Fix backspace not deleting tabs, also make delimiteMate work
set breakindent
set conceallevel=0
set cursorline  " Highlight current line (slow as fuck)
set expandtab
set hidden    " remember undo after quitting
set hlsearch
set ignorecase
set incsearch
set lazyredraw  " Try to not draw while doing macros (helps with scrolling performance)
set laststatus=2
set linespace=2
set magic
set mouse=a
set nobackup
set nofoldenable
set nostartofline
set noswapfile
set nowritebackup
set number
set pastetoggle=<F2>
set relativenumber
set scrolloff=7
set shiftwidth=2
set showmatch
set smartcase
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set updatetime=750
set virtualedit=block
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set wildignorecase
set wildmenu
set wildmode=full
let showbreak = '└ '

" Netrw options
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'
let g:netrw_fastbrowse = 2
let g:netrw_list_hide = '.*\.pyc$,\.DS_Store'
let g:netrw_liststyle = 4
let g:netrw_silent = 1
let g:netrw_sort_options = 'i'
let g:netrw_sort_sequence = '[\/]$'
let g:netrw_special_syntax = 1
let g:netrw_winsize = 25

if has('nvim')
  set inccommand=split

  tnoremap <c-h> <c-\><c-n><C-w>h
  tnoremap <c-j> <c-\><c-n><C-w>j
  tnoremap <c-k> <c-\><c-n><C-w>k
  tnoremap <c-l> <c-\><c-n><C-w>l
  tnoremap jj    <c-\><c-n>
else
  set ttymouse=xterm2
endif

" GUI options
if has("gui_running")
  set guicursor+=a:blinkon0
  set guifont=Fira\ Code:h16
  " set guifont=Monospace\ 10
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T
  set guioptions-=a
  set guioptions-=l
  set guioptions-=m
  set guioptions-=r
  set macligatures
  set visualbell t_vb=
endif

" CUSTOM KEYBINDINGS
" Vim specific
inoremap jj <Esc>
let mapleader = "\<Space>"

" Some expansions
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;
inoremap ,M ->
inoremap ,m <c-o>A-><c-f>
inoremap ,n =>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-o> <esc>o

" QOL remappings
cnoremap <c-a> <c-b>
nmap     <c-down> ]c
nmap     <c-up>   [c
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <leader>n :e <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <silent> <c-end>   :lnext<cr>
nnoremap <silent> <c-home>  :lprevious<cr>
nnoremap <silent> <end>     :cnext<cr>
nnoremap <silent> <home>    :cprevious<cr>
nnoremap <silent> <leader>= <c-w>=
nnoremap <silent> <leader>X :qa!<cr>
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>p :set wrap!<cr>
nnoremap <silent> <leader>q :%bdelete<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>x :qa<cr>
nnoremap <silent> <leader>Ç :lclose<cr>
nnoremap <silent> <leader>ç :lwindow<cr>
nnoremap <silent> ª :bdelete!<cr>
nnoremap <silent> º :bdelete<cr>
nnoremap <silent> Ç :cclose<cr>
nnoremap <silent> ç :cwindow<cr>
nnoremap M <c-w>o
nnoremap Q @q
nnoremap Y y$
nnoremap Ñ ?
nnoremap ñ /
noremap ' `
noremap <silent> <leader>, :set relativenumber! cursorline!<cr>
noremap <silent> <leader>2 :set shiftwidth=2 tabstop=2<cr>
noremap <silent> <leader>4 :set shiftwidth=4 tabstop=4<cr>
noremap <silent> <leader><cr> :noh<cr>
noremap H g^
noremap L g$
vnoremap <silent> Q :norm @q<cr>

" Properly indent text when pasting
nnoremap p p`[v`]=
nnoremap P P`[v`]=
nnoremap gp p
nnoremap gP P

" Select last inserted text
nnoremap gV `[v`]

" Change word under cursor or selection with yanked
nnoremap R ciw<c-r>0<esc>
vnoremap R "0p

" Repeat command on each line of visual selection
vnoremap <silent> . :normal .<cr>

" Maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" If I have a visual selection and press * I want it to show ocurrences
vnoremap * ymi/<c-r>"<cr>`i
vnoremap # y?<c-r>"<cr>

" Save with root permissions
command! W w !sudo tee % > /dev/null

" Quick replace word under cursor
nnoremap <leader>s  :%s///g<left><left><left>
nnoremap <leader>S  :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap <leader>s  :%s///g<left><left><left>
vnoremap <leader>S y:%s/<c-r>"//g<left><left>

" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
vnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>d "+d

" Move a line of text using alt+[jk]
" Weird characters are when meta key is not recognized
nnoremap <silent> <M-j> mz:m+<cr>`z
nnoremap <silent> <M-k> mz:m-2<cr>`z
vnoremap <silent> <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <silent> <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
nnoremap <silent> ¶ mz:m+<cr>`z
nnoremap <silent> § mz:m-2<cr>`z
vnoremap <silent> ¶ :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <silent> § :m'<-2<cr>`>my`<mzgv`yo`z

" Navigate buffers
nnoremap <BS> <C-^>
nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprevious<cr>
nnoremap <silent> <leader>1 :bfirst<cr>
nnoremap <silent> <leader>0 :blast<cr>
nnoremap <silent> <leader>t :enew<cr>

" Remapping <tab> makes <c-i> not work
nnoremap <c-e> <c-i>

" Tags
nmap t <c-]>
nmap T g]
nmap <silent> gt :vsp <cr><c-]>
nmap <silent> gT :sp <cr><c-]>
nnoremap <silent> <leader>T :VimProcBang ctags<cr>

" Work with splits
nnoremap <leader>v <C-W>v
nnoremap <leader>h <C-W>s

" sort operator and mappings
function! SortLinesOpFunc(...)
    '[,']sort
endfunction

function! SortReverseLinesOpFunc(...)
    '[,']sort!
endfunction

nnoremap <silent> gs :<C-U>set operatorfunc=SortLinesOpFunc<CR>g@
vnoremap <silent> gs :sort<cr>
nnoremap <silent> gr :<C-U>set operatorfunc=SortReverseLinesOpFunc<CR>g@
vnoremap <silent> gr :sort!<cr>

" The Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ag_highlight = 1
  nnoremap <leader>f  :Ag! -Q ""<left>
  nnoremap <leader>F  :Ag! -Q ""<left><c-r><c-w>
  vnoremap <leader>f y:Ag! -Q "<c-r>""

  nnoremap K  :silent Ag! -Q "<c-r><c-w>"<cr>
  vnoremap K y:silent Ag! -Q "<c-r>""<cr>
endif

" Grep operator
nnoremap <silent> <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <silent> <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  if executable('ag')
    silent execute "Ag " . shellescape(@@)
  else
    silent execute "grep -R " . shellescape(@@) . " ."
  endif
endfunction

" Fast vimrc editing
nnoremap <silent> <leader>e :e! $MYVIMRC<cr>
nnoremap <silent> <leader>E :so $MYVIMRC<cr>

" Duplicate file
nnoremap <leader>W :saveas <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Commands
" Autosave on focus lost
autocmd FocusLost * silent! wa

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Fold method='indent' + manual folding (with zo and zc)
au BufReadPre * setlocal foldmethod=indent
au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Hex mode
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

"""""""""""""""""""
" Plugin specific "
"""""""""""""""""""
" airline
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'

" autoformat
nnoremap <silent> <leader>b :Autoformat<cr>
autocmd FileType javascript nnoremap <silent> <buffer> <leader>b :!eslint --fix %<cr>

" bdelete (don't close pane)
nnoremap <silent> <leader>ª :Bdelete!<cr>
nnoremap <silent> <leader>º :Bdelete<cr>

" csv
hi CSVColumnEven ctermbg=242 guibg=#6C6C6C
hi CSVColumnOdd  term=NONE   ctermbg=NONE

" delimitmate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" dispatch
nnoremap <leader>. :Start<space>
nnoremap <silent> <leader>m :Dispatch<cr>
vnoremap <silent> <leader>m :Dispatch<cr>

" fugitive
nmap <silent> <leader>- :Gstatus<cr><c-n>

" fzf
autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
let g:fzf_command_prefix = 'F'
nnoremap <silent> <leader><leader> :FBuffers<cr>
nnoremap <silent> <leader>H :FHistory<cr>
nnoremap <silent> <leader>O :FFiles<cr>
nnoremap <silent> <leader>R :FTags<cr>
nnoremap <silent> <leader>j :FSnippets<cr>
nnoremap <silent> <leader>o :FGFiles<cr>
nnoremap <silent> <leader>r :FBTags<cr>
nnoremap <silent> <leader>ñ :FLines<cr>
set rtp+=/usr/local/opt/fzf

" gitgutter
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" goyo
nnoremap <silent> <leader>z :Goyo<cr>

" gundo
nnoremap <silent> <leader>u :GundoToggle<cr>

" highlightedyank
hi HighlightedyankRegion ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE

" jsx
let g:jsx_ext_required = 0

" lion
let b:lion_squeeze_spaces = 1
nmap <leader>a= mzglip='z

" neomake
autocmd BufWritePost * Neomake
let g:neomake_go_enabled_makers = ['golint', 'govet', 'go' ]
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_php_enabled_makers = ['php', 'phpmd']
let g:neomake_python_flake8_args = ['--ignore', 'E402,E501']
let g:neomake_yaml_yamllint_args = ['-f', 'parsable', '-d', 'relaxed']

" nerdtree
autocmd FileType nerdtree setlocal relativenumber
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowLineNumbers = 1
nnoremap <silent> <leader>K :NERDTreeFind<cr>
nnoremap <silent> <leader>k :NERDTreeToggle<cr>

" rspec
let g:rspec_command = "Dispatch bin/rspec {spec}"
autocmd FileType ruby nnoremap <silent> <buffer> <leader>sf :call RunCurrentSpecFile()<cr>
autocmd FileType ruby nnoremap <silent> <buffer> <leader>ss :call RunNearestSpec()<cr>
autocmd FileType ruby nnoremap <silent> <buffer> <leader>sl :call RunLastSpec()<cr>
autocmd FileType ruby nnoremap <silent> <buffer> <leader>sa :call RunAllSpecs()<cr>

" session
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
nnoremap <c-p> :OpenSession!<space>
nnoremap <c-s> :SaveSession!<space>

" sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" tagbar
let g:tagbar_compact = 1
nmap <silent> <leader>l :TagbarToggle<CR>

" targets
let g:targets_pairs = '()b {}B []r <>'

" tmux navigator
let g:tmux_navigator_save_on_switch = 1

" typescript
autocmd FileType typescript nnoremap <silent> <buffer> T :YcmCompleter GoToReferences<cr>
autocmd FileType typescript nnoremap <silent> <buffer> t :YcmCompleter GoToDefinition<cr>
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

" ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"

" ysurround: Swap double quotes with single quotes
nnoremap <silent> <leader>" :normal mzcs'"`z<cr>
nnoremap <silent> <leader>' :normal mzcs"'`z<cr>

" youcompleteme
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_python_binary_path = 'python'

"""""""""""""""""""""
"  Custom commands  "
"""""""""""""""""""""
command! Dcup   !docker-compose up -d
command! Dcps   !docker-compose ps
command! Dcstop !docker-compose stop

" US ANSI layout
" nnoremap <silent> <leader>` :Bdelete<cr>
" nnoremap <silent> <leader>~ :Bdelete!<cr>
" nnoremap <silent> \  :cwindow<cr>
" nnoremap <silent> \| :cclose<cr>
" nnoremap <silent> `  :bdelete<cr>
" nnoremap <silent> ~  :bdelete!<cr>
