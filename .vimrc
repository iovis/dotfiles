"dein Scripts-----------------------------
set nocompatible

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
" call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('elzr/vim-json')
call dein#add('haya14busa/dein-command.vim')
call dein#add('henrik/vim-indexed-search')
call dein#add('honza/vim-snippets')
call dein#add('jmcantrell/vim-virtualenv')
call dein#add('junegunn/fzf.vim')
call dein#add('junegunn/goyo.vim')
" call dein#add('junegunn/vim-peekaboo')
call dein#add('justinmk/vim-sneak')
call dein#add('kana/vim-textobj-entire')
call dein#add('kana/vim-textobj-indent')
call dein#add('kana/vim-textobj-user')
call dein#add('kchmck/vim-coffee-script')
call dein#add('majutsushi/tagbar')
call dein#add('marcweber/vim-addon-mw-utils')  " Required by vim-snippets
call dein#add('mattn/emmet-vim')
call dein#add('metakirby5/codi.vim')
call dein#add('moll/vim-bbye')
call dein#add('mxw/vim-jsx')
call dein#add('nginx.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('pbrisbin/vim-mkdir')
call dein#add('raimondi/delimitMate.git')
call dein#add('rking/ag.vim')
call dein#add('romainl/vim-qf')
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
call dein#add('tpope/vim-eunuch')                " Unix helpers (:Move, :Remove...)
call dein#add('tpope/vim-dispatch')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-git')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-repeat')
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
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" CUSTOM SETTINGS
colorscheme base16-default-dark

syntax enable
set autoindent
set autoread
set autowriteall
set background=dark
set backspace=indent,eol,start   " Fix backspace not deleting tabs, also make delimiteMate work
set breakindent
set conceallevel=0
set expandtab
set hidden    " remember undo after quitting
set hlsearch
set ignorecase
set incsearch
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
set wildmode=longest:full,full
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
  tnoremap <c-h> <C-\><C-n><C-w>h
  tnoremap <c-j> <C-\><C-n><C-w>j
  tnoremap <c-k> <C-\><C-n><C-w>k
  tnoremap <c-l> <C-\><C-n><C-w>l
  tnoremap jj <C-\><C-n>
else
  " Mouse support
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
inoremap ,m <c-o>A-><c-f>
inoremap ,M ->
inoremap ,n =>
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;
" inoremap (<cr> (<cr>)<esc>O
" inoremap {<cr> {<cr>}<esc>O
" inoremap [<cr> [<cr>]<esc>O
inoremap {; {<cr>};<esc>O
inoremap {, {<cr>},<esc>O
inoremap [; [<cr>];<esc>O
inoremap [, [<cr>],<esc>O

" QOL remappings
cnoremap <c-a> <c-b>
nnoremap - ]c
nnoremap <C-End>  :lnext<cr>
nnoremap <C-Home> :lprevious<cr>
nnoremap <End>    :cnext<cr>
nnoremap <Home>   :cprevious<cr>
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <leader>X :qa!<cr>
nnoremap <leader>c :close<cr>
nnoremap <leader>n :e <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>p :set wrap!<cr>
nnoremap <leader>q :%bdelete<cr>
nnoremap <leader>w :w!<cr>
nnoremap <leader>x :qa<cr>
nnoremap <leader>Ç :lclose<cr>
nnoremap <leader>ç :lwindow<cr>
nnoremap M <c-w>o
nnoremap Q @q
nnoremap Y y$
nnoremap _ [c
nnoremap ª :bdelete!<cr>
nnoremap º :bdelete<cr>
nnoremap Ç :cclose<cr>
nnoremap Ñ ?
nnoremap ç :cwindow<cr>
nnoremap ñ /
noremap ' `
noremap <silent> <leader><cr> :noh<cr>
noremap H g^
noremap L g$
vnoremap Q :norm @q<cr>


" bind K to search word under cursor in project
nnoremap K  :silent grep! "\b<cword>\b"<CR>:copen<CR>
vnoremap K y:silent grep! "<c-r>""<CR>:copen<CR>

" Change word under cursor or selection with yanked
nnoremap R diw"0P
vnoremap R "_d"0P

" Repeat command on each line of visual selection
vnoremap . :normal .<cr>

" Maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Don't jump to the next ocurrence with * and #
nnoremap * :silent keepjumps normal! mi*`i<CR>
nnoremap # :silent keepjumps normal! mi#`i<CR>

" If I have a visual selection and press * I want it to show ocurrences
vnoremap * ymi/<c-r>"<cr>`i
vnoremap # y?<c-r>"<cr>

" Save with root permissions
command! W w !sudo tee % > /dev/null

" Open file explorer
nnoremap <silent> <leader>k :Lexplore<cr>

" Quick replace word under cursor
nnoremap <leader>s  :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap <leader>s y:%s/<c-r>"//g<left><left>

" Quick very magic substitue
nnoremap <leader>S :%s/\v//g<left><left><left>

" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
vnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>d "+d

" Quick uppercase or lowercase word
nnoremap <leader>U mzgUiw`z
nnoremap <leader>u mzguiw`z

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
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprevious<cr>
nnoremap <leader>1 :bfirst<cr>
nnoremap <leader>0 :blast<cr>
nnoremap <leader><Tab> :enew<cr>
nnoremap <leader><leader> :ls<cr>:b!<space>

" Remapping <tab> makes <c-i> not work
nnoremap <c-e> <c-i>

" Tags
nnoremap t <C-]>
nnoremap <leader>t g]
nnoremap <leader>T :VimProcBang ctags<cr>
set tags=.tags,.gemtags

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
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

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
nnoremap <leader>e :e! $MYVIMRC<cr>
nnoremap <leader>E :so $MYVIMRC<cr>

" Duplicate file
nnoremap <leader>D :saveas <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Sessions
nnoremap <c-s> :mksession! ~/.vim/sessions/
nnoremap <c-p> :source ~/.vim/sessions/

" Make
nnoremap <leader>m :make %<cr>

" Commands
augroup vimrc
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
augroup END

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
" Some plugin settings
hi CSVColumnEven ctermbg=242 guibg=#6C6C6C
hi CSVColumnOdd  term=NONE   ctermbg=NONE
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowLineNumbers = 1
let b:lion_squeeze_spaces = 1
let delimitMate_expand_cr = 1
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:ag_apply_qmappings = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'
" let g:ctrlp_map = ''
let g:fzf_command_prefix = 'FZF'
let g:gitgutter_map_keys = 0
let g:jsx_ext_required = 0
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_php_enabled_makers = ['php', 'phpmd']
let g:neomake_python_flake8_args = ['--ignore', 'E402,E501']
let g:qf_mapping_ack_style = 1
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:sneak#use_ic_scs = 1
let g:tagbar_compact = 1
let g:tmux_navigator_save_on_switch = 1
let g:vim_markdown_folding_disabled = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-j>', '<C-n>', '<Down>']
set rtp+=/usr/local/opt/fzf

" The Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0

  " Custom :Ag command
  " command! -nargs=+ -complete=file -bar Ag silent grep! <args>|cwindow|redraw!

  " Mappings
  nnoremap <leader>f  :Ag!<space>
  vnoremap <leader>f y:Ag! <c-r>"
endif

" NERDTree
augroup nerdtree
  autocmd! FileType nerdtree setlocal relativenumber
augroup END

nnoremap <silent> <leader>k :NERDTreeToggle<cr>
nnoremap <silent> <leader>K :NERDTreeFind<cr>

" Ysurround: Swap double quotes with single quotes
nnoremap <leader>' :normal mzcs"'`z<cr>
nnoremap <leader>" :normal mzcs'"`z<cr>

" Distraction free
nnoremap <silent> <leader>z :Goyo<cr>

" Gundo
nnoremap U :GundoToggle<cr>

" Don't mess up the layout when closing buffers
nnoremap º :Bdelete<cr>
nnoremap ª :Bdelete!<cr>

" Neomake
augroup neomake
  autocmd! BufWritePost,BufEnter * Neomake
  command! Fixneo call neomake#signs#DefineHighlights() | call neomake#highlights#DefineHighlights()
  nnoremap <leader>- :Fixneo<cr>
augroup END

" CtrlP
" nnoremap <leader><leader> :CtrlPBuffer<cr>
" nnoremap <leader>H :CtrlPMRUFiles<cr>
" nnoremap <leader>O :e **/
" nnoremap <leader>R :CtrlPTag<cr>
" nnoremap <leader>o :CtrlP<cr>
" nnoremap <leader>r :CtrlPBufTag<cr>
" nnoremap <leader>ñ :CtrlPLine<cr>

" FZF
nnoremap <leader><leader> :FZFBuffers<cr>
nnoremap <leader>H :FZFHistory<cr>
nnoremap <leader>O :FZFFiles<cr>
nnoremap <leader>R :FZFTags<cr>
nnoremap <leader>o :FZFGFiles<cr>
nnoremap <leader>r :FZFBTags<cr>
nnoremap <leader>ñ :FZFLines<cr>

" Session
nnoremap <c-s> :SaveSession!<space>
nnoremap <c-p> :OpenSession!<space>

" Tagbar
nmap <leader>l :TagbarToggle<CR>

" Make
nnoremap <leader>m :Make %<cr>

" Quickfix mappings
nmap <C-Home>  <Plug>QfLnext
nmap <C-End>   <Plug>QfLprevious
nmap <End>     <Plug>QfCnext
nmap <Home>    <Plug>QfCprevious
nmap <leader>ç <Plug>QfLtoggle
nmap Ç <Plug>QfCtoggle
nmap ç <Plug>QfSwitch
