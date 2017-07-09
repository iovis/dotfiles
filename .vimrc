"dein Scripts-----------------------------
set nocompatible
filetype off

set runtimepath+=~/.dotfiles/.vim/bundle/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.dotfiles/.vim/bundle'))
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('airblade/vim-gitgutter')
call dein#add('benekastah/neomake')
call dein#add('cakebaker/scss-syntax.vim')
call dein#add('chiel92/vim-autoformat')
call dein#add('chrisbra/csv.vim')
call dein#add('chriskempson/base16-vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('digitaltoad/vim-pug')
call dein#add('elzr/vim-json')
call dein#add('haya14busa/dein-command.vim')
call dein#add('honza/vim-snippets')
call dein#add('iovis9/vim-searchindex')
call dein#add('jmcantrell/vim-virtualenv')
call dein#add('junegunn/fzf.vim')
call dein#add('junegunn/goyo.vim')
call dein#add('kana/vim-textobj-entire')
call dein#add('kana/vim-textobj-indent')
call dein#add('kana/vim-textobj-user')
call dein#add('kchmck/vim-coffee-script')
call dein#add('leafgarland/typescript-vim')
call dein#add('majutsushi/tagbar')
call dein#add('marcweber/vim-addon-mw-utils')  " Required by vim-snippets
call dein#add('mattn/emmet-vim')
call dein#add('metakirby5/codi.vim')
call dein#add('moll/vim-bbye')
call dein#add('mxw/vim-jsx')
call dein#add('vim-scripts/nginx.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('pbrisbin/vim-mkdir')
call dein#add('raimondi/delimitMate.git')
call dein#add('rking/ag.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('shawncplus/phpcomplete.vim')
call dein#add('shougo/vimproc.vim', {'build' : 'make'})
call dein#add('sirver/ultisnips')
call dein#add('sjl/gundo.vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tmux-plugins/vim-tmux-focus-events')
call dein#add('tommcdo/vim-lion')
call dein#add('tomtom/tlib_vim')                 " Required by vim-snippets
call dein#add('tpope/vim-bundler')
call dein#add('tpope/vim-characterize')          " Use ga to see additional representations of that character
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-eunuch')                " Unix helpers (:Move, :Remove...)
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-git')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-rhubarb')
call dein#add('tpope/vim-speeddating')
call dein#add('tpope/vim-surround')
call dein#add('valloric/youcompleteme')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('vim-ruby/vim-ruby')
call dein#add('wellle/targets.vim')
call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-session')

call dein#end()

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

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
let g:netrw_liststyle = 1
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
inoremap ,M ->
inoremap ,m <c-o>A-><c-f>
inoremap ,n =>
inoremap ;; <c-o>A;
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-o> <esc>o
inoremap [, [<cr>],<esc>O
inoremap [; [<cr>];<esc>O
inoremap {, {<cr>},<esc>O
inoremap {; {<cr>};<esc>O

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
noremap <silent> <leader><cr> :noh<cr>
noremap H g^
noremap L g$
onoremap ar a]
onoremap ir i]
vnoremap <silent> Q :norm @q<cr>

" bind K to search word under cursor in project
nnoremap K  :silent grep! "\b<cword>\b"<cr>:copen<cr>
vnoremap K y:silent grep! "<c-r>""<cr>:copen<cr>

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

" Open file explorer
nnoremap <silent> <leader>k :Lexplore<cr>

" Quick replace word under cursor
nnoremap s  :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap s y:%s/<c-r>"//g<left><left>

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
nnoremap <leader><leader> :ls<cr>:b!<space>

" Remapping <tab> makes <c-i> not work
nnoremap <c-e> <c-i>

" Tags
nnoremap t <C-]>
nnoremap T g]
vnoremap t <C-]>
vnoremap T g]
nnoremap <silent> gt :vsp <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <silent> gT :sp <cr>:exec("tag ".expand("<cword>"))<cr>
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

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
endfunction

" Fast vimrc editing
nnoremap <silent> <leader>e :e! $MYVIMRC<cr>
nnoremap <silent> <leader>E :so $MYVIMRC<cr>

" Duplicate file
nnoremap <silent> <leader>D :saveas <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Sessions
nnoremap <c-s> :mksession! ~/.vim/sessions/
nnoremap <c-p> :source ~/.vim/sessions/

" Make
nnoremap <silent> <leader>m :make<cr>
nnoremap <leader>: :!

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
" ag
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ag_highlight = 1
  nnoremap <leader>f  :Ag! -Q<space>
  vnoremap <leader>f y:Ag! -Q <c-r>"
endif

" airline
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'

" autoformat
nnoremap <silent> <leader>b :Autoformat<cr>

" bdelete (don't close pane)
nnoremap <silent> <leader>ª :Bdelete!<cr>
nnoremap <silent> <leader>º :Bdelete<cr>

" csv
hi CSVColumnEven ctermbg=242 guibg=#6C6C6C
hi CSVColumnOdd  term=NONE   ctermbg=NONE

" delimitmate
let delimitMate_expand_cr = 1

" dispatch
nnoremap <leader>: :Start<space>
nnoremap <silent> <leader>m :Dispatch<cr>
vnoremap <leader>: :Start<space>
vnoremap <silent> <leader>m :Dispatch<cr>

" fugitive
nnoremap <silent> <leader>- :Gstatus<cr>gg<c-n>

" fzf
autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
let g:fzf_command_prefix = 'FZF'
nnoremap <silent> <leader><leader> :FZFBuffers<cr>
nnoremap <silent> <leader>H :FZFHistory<cr>
nnoremap <silent> <leader>O :FZFFiles<cr>
nnoremap <silent> <leader>R :FZFTags<cr>
nnoremap <silent> <leader>j :FZFSnippets<cr>
nnoremap <silent> <leader>o :FZFGFiles<cr>
nnoremap <silent> <leader>r :FZFBTags<cr>
nnoremap <silent> <leader>ñ :FZFLines<cr>
set rtp+=/usr/local/opt/fzf

" gitgutter
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" goyo
nnoremap <silent> <leader>z :Goyo<cr>

" gundo
nnoremap <silent> U :GundoToggle<cr>

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

" session
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
nnoremap <c-p> :OpenSession!<space>
nnoremap <c-s> :SaveSession!<space>

" tagbar
let g:tagbar_compact = 1
nmap <silent> <leader>l :TagbarToggle<CR>

" tmux navigator
let g:tmux_navigator_save_on_switch = 1

" typescript
autocmd FileType typescript nnoremap <silent> <buffer> <leader>t :YcmCompleter GetType<cr>
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
