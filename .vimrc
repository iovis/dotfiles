scriptencoding utf-8
filetype off

call plug#begin()

" Add or remove your plugins here:
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'chiel92/vim-autoformat'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fishbullet/deoplete-ruby'
Plug 'honza/vim-snippets'
Plug 'iovis9/substitute.vim'
Plug 'iovis9/vim-searchindex'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'metakirby5/codi.vim'
Plug 'mhartington/nvim-typescript'
Plug 'mileszs/ack.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'raimondi/delimitMate'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'shougo/context_filetype.vim'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'shougo/echodoc.vim'
Plug 'shougo/neco-syntax'
Plug 'shougo/neco-vim'
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-characterize'          " Use ga to see additional representations of that character
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'                " Unix helpers (:Move, :Remove...)
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
" Plug 'uplus/deoplete-solargraph'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'zchee/deoplete-jedi'

call plug#end()

" CUSTOM SETTINGS
filetype plugin indent on
colorscheme base16-default-dark

if !has('g:syntax_on')
  syntax enable
endif

set autoindent
set autoread
set autowriteall
set background=dark
set backspace=indent,eol,start   " Fix backspace not deleting tabs, also make delimiteMate work
set breakindent
set completeopt-=preview
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
set termguicolors
set updatetime=750
set virtualedit=block
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set wildignorecase
set wildmenu
set wildmode=full
let &showbreak = '└ '

if has('nvim')
  set inccommand=split

  tnoremap <c-h> <c-\><c-n><C-w>h
  tnoremap <c-j> <c-\><c-n><C-w>j
  tnoremap <c-k> <c-\><c-n><C-w>k
  tnoremap <c-l> <c-\><c-n><C-w>l
  tnoremap jj    <c-\><c-n>
else
  set ttymouse=xterm2
  set notermguicolors
endif

" GUI options
if has('gui_running')
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
let g:mapleader = "\<Space>"
nnoremap <space> <nop>
xnoremap <space> <nop>

" Some expansions
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;
inoremap ,M ->
inoremap ,m <c-o>A-><c-f>
inoremap ,n =>

" QOL remappings
cnoremap <c-a> <c-b>
cnoremap <c-k> <up>
cnoremap <c-j> <down>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-O> <esc>O
inoremap <m-o> <esc>o
nmap     <c-down> ]c
nmap     <c-up>   [c
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <leader>. @@
nnoremap <leader>: @:
nnoremap <leader>n :e<space>
nnoremap <m-O> mzO<esc>`z
nnoremap <m-o> mzo<esc>`z
nnoremap Ø   mzO<esc>`z
nnoremap ø   mzo<esc>`z
nnoremap <silent> <down>  :cnext<cr>
nnoremap <silent> <up>    :cprevious<cr>
nnoremap <silent> <right> :lnext<cr>
nnoremap <silent> <left>  :lprevious<cr>
nnoremap <silent> <leader>= <c-w>=
nnoremap <silent> <leader>X :qa!<cr>
nnoremap <silent> <leader>\| <c-w>\|
nnoremap <silent> <leader>_ <c-w>_
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>p :set wrap!<cr>
nnoremap <silent> <leader>q :%bdelete<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>x :qa<cr>
nnoremap <silent> <leader>ª :bdelete!<cr>
nnoremap <silent> <leader>º :bdelete<cr>
nnoremap <silent> <leader>Ç :lclose<cr>
nnoremap <silent> <leader>ç :lwindow<cr>
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G
nnoremap <silent> ª :bp!\|bd! #<cr>
nnoremap <silent> º :bp\|bd #<cr>
nnoremap <silent> Ç :cclose<cr>
nnoremap <silent> ç :cwindow<cr>
nnoremap M <c-w>o
nnoremap Q @q
nnoremap Y y$
nnoremap Ñ ?
nnoremap ñ /
noremap ' `
noremap <silent> <leader>, :set relativenumber! cursorline!<cr>
noremap <silent> <leader>; :set number! relativenumber! cursorline!<cr>
noremap <silent> <leader><cr> :noh<cr>
noremap H g^
noremap L g$
xnoremap <silent> Q :norm @q<cr>

" Properly indent text when pasting
nnoremap p p`[v`]=
nnoremap P P`[v`]=
nnoremap gp p
nnoremap gP P

" Repeat command in last tmux split. "-t !" refers to last pane
nnoremap <silent> <leader>i :silent !tmux send-keys -t \! Up Enter<cr>

" Execute current line in last tmux split
nnoremap <silent> <leader>I :silent exec '!tmux send-keys -t \! ' . shellescape(getline('.')) . ' Enter'<cr>

" Select last inserted text
nnoremap gV `[v`]

" Change word under cursor or selection with yanked
nnoremap R ciw<c-r>0<esc>
xnoremap R "0p

" Repeat command on each line of visual selection
xnoremap <silent> . :normal .<cr>

" Maintain Visual Mode after shifting > and <
xnoremap < <gv
xnoremap > >gv

" If I have a visual selection and press * I want it to show ocurrences
xnoremap * ymi/<c-r>"<cr>`i
xnoremap # y?<c-r>"<cr>

" Save with root permissions
command! W w !sudo tee % > /dev/null

" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
xnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>D "+D
xnoremap <leader>d "+d

" Move a line of text using alt+[jk]
" Weird characters are when meta key is not recognized
nnoremap <silent> <M-j> :m+<cr>==
nnoremap <silent> <M-k> :m-2<cr>==
xnoremap <silent> <M-j> :m'>+<cr>`<my`>mzgv=gv`yo`z
xnoremap <silent> <M-k> :m'<-2<cr>`>my`<mzgv=gv`yo`z
nnoremap <silent> ¶ :m+<cr>==
nnoremap <silent> § :m-2<cr>==
xnoremap <silent> ¶ :m'>+<cr>`<my`>mzgv=gv`yo`z
xnoremap <silent> § :m'<-2<cr>`>my`<mzgv=gv`yo`z

" Navigate buffers
nnoremap <BS> <C-^>
nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprevious<cr>
nnoremap <silent> <leader>t :enew<cr>

" Remapping <tab> makes <c-i> not work
nnoremap <c-e> <c-i>

" Tags
nmap t <c-]>
nmap T g]
nmap <silent> gt :vsp <cr><c-]>
nmap <silent> gT :sp <cr><c-]>
nnoremap <silent> <leader>T :Dispatch ctags<cr>

" Work with splits
nnoremap <leader>v <c-w>v
nnoremap <leader>h <c-w>s

" sort operator and mappings
function! SortLinesOpFunc(...)
  '[,']sort
endfunction

function! SortReverseLinesOpFunc(...)
  '[,']sort!
endfunction

nnoremap <silent> gs :<c-u>set operatorfunc=SortLinesOpFunc<cr>g@
xnoremap <silent> gs :sort<cr>
nnoremap <silent> gr :<c-u>set operatorfunc=SortReverseLinesOpFunc<cr>g@
xnoremap <silent> gr :sort!<cr>

" Fast vimrc editing
nnoremap <silent> <leader>ee :e! $MYVIMRC<cr>
nnoremap <silent> <leader>ev :vs $MYVIMRC<cr>
nnoremap <silent> <leader>eh :sp $MYVIMRC<cr>
nnoremap <silent> <leader>es :so $MYVIMRC<cr>
nnoremap <silent> <leader>em :e! ~/.dotfiles/.vimrc_min<cr>
nnoremap <silent> <leader>et :e! ~/.tmux.conf<cr>

" Duplicate file
nnoremap <leader>W :saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>

" Toggle spell check
nnoremap <leader>A :setlocal spell! spelllang=en_us<cr>

" Scratch buffer
command! ScratchBuffer enew | setlocal buftype=nofile bufhidden=hide noswapfile
nnoremap <silent> <leader>J :ScratchBuffer<cr>

" Autocmds
augroup vimrc
  autocmd!

  " Autosave on focus lost
  autocmd FocusLost * silent! wa

  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup end

" Colors
" hi IncSearch ctermbg=none ctermfg=110 term=bold,underline guibg=#8fafd7 guifg=#262626
" hi Search ctermbg=none ctermfg=110 term=bold,underline guibg=#8fafd7 guifg=#262626
" hi IncSearch ctermbg=none ctermfg=110 term=bold,underline guibg=none guifg=#8fafd7 gui=underline,bold
" hi Search ctermbg=none ctermfg=110 term=bold,underline guibg=none guifg=#8fafd7 gui=underline,bold

"""""""""""""""""""
" Plugin specific "
"""""""""""""""""""
" Ack {{{ "
let g:ackhighlight = 1
let g:ack_use_dispatch = 1
let g:ackprg = 'rg --vimgrep --smart-case'
nnoremap <leader>f  :Ack! -F ""<left>
xnoremap <leader>f y:Ack! -F "<c-r>""
nnoremap K  :silent Ack! -F "<c-r><c-w>"<cr>
xnoremap K y:silent Ack! -F "<c-r>""<cr>

" Use rg over Grep
if executable('rg')
  set grepprg=ag\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
" }}} Ack "

" airline {{{ "
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'

let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': ' 0 ',
      \ '1': ' 1 ',
      \ '2': ' 2 ',
      \ '3': ' 3 ',
      \ '4': ' 4 ',
      \ '5': ' 5 ',
      \ '6': ' 6 ',
      \ '7': ' 7 ',
      \ '8': ' 8 ',
      \ '9': ' 9 '
      \}

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" }}} airline "

" autoformat {{{ "
nnoremap <silent> <leader>b :Autoformat<cr>
xnoremap <silent> <leader>b :Autoformat<cr>

let g:formatdef_sqlformat_sql = '"sqlformat -k upper -r -"'
let g:formatters_sql = ['sqlformat_sql']
let g:formatters_javascript = ['prettier']
let g:formatters_json = ['prettier']
" }}} autoformat "

" bufonly {{{ "
nnoremap <silent> <leader>Q :BufOnly!<cr>
" }}} bufonly "

" csv {{{ "
hi CSVColumnEven ctermbg=242 guibg=#6C6C6C
hi CSVColumnOdd  term=NONE   ctermbg=NONE
" }}} csv "

" dadbod {{{ "
" let g:db = 'postgres://localhost/rubicon_development'
" }}} dadbod "

" delimitmate {{{ "
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" }}} delimitmate "

" deoplete {{{ "
let g:deoplete#auto_complete_delay = 100
let g:deoplete#enable_at_startup = 1

" let g:deoplete#tag#cache_limit_size = 5000000
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('ultisnips', 'rank', 1000)
call deoplete#custom#source('syntax', 'rank', 100)

" Use tab to go through the results
inoremap <expr><tab> pumvisible()? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible()? "\<c-p>" : "\<s-tab>"

" deoplete + multiple cursors fix
function! Multiple_cursors_before()
  let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
  let b:deoplete_disable_auto_complete = 0
endfunction
" }}} deoplete "

" dispatch {{{ "
nnoremap <leader>! :Start<space>
" }}} dispatch "

" echodoc {{{ "
set cmdheight=2
set noshowmode
let g:echodoc_enable_at_startup = 1
" }}} echodoc "

" emmet {{{ "
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\    'extends' : 'jsx',
\  },
\}
" }}} emmet "

" fugitive {{{ "
nmap <leader>gc :Gcommit<cr>
nmap <leader>gl :Gpull<cr>
nmap <leader>gm :Gmerge<cr>
nmap <leader>go :Gread<cr>
nmap <leader>gp :Gpush<cr>
nmap <leader>gw :Gwrite<cr>

nmap <silent> <leader>-  :Gstatus<cr><c-n>
nmap <silent> <leader>gb :Gblame<cr>
nmap <silent> <leader>gd :Gvdiff<cr>
nmap <silent> <leader>gg :Gbrowse<cr>
nmap <silent> <leader>gh :Glog<cr>

xmap <silent> <leader>gg :Gbrowse<cr>
xmap <silent> <leader>gh :Glog<cr>
" }}} fugitive "

" fzf {{{ "
set runtimepath+=/usr/local/opt/fzf

augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end

" Use git files if inside a git repo, otherwise look for everything
nnoremap <expr> <leader>o system('git rev-parse --is-inside-work-tree') =~ 'true'
  \ ? ':GFiles<cr>'
  \ : ':Files<cr>'

nnoremap <silent> <c-p> :Commands<cr>
nnoremap <silent> <leader><leader> :Buffers<cr>
nnoremap <silent> <leader>B :BCommits<cr>
nnoremap <silent> <leader>F :Filetypes<cr>
nnoremap <silent> <leader>H :History<cr>
nnoremap <silent> <leader>O :Files<cr>
nnoremap <silent> <leader>R :Tags<cr>
nnoremap <silent> <leader>j :GFiles?<cr>
nnoremap <silent> <leader>l :Commits<cr>
nnoremap <silent> <leader>r :BTags<cr>
nnoremap <silent> <leader>ñ :BLines<cr>
" }}} fzf "

" gitgutter {{{ "
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
" }}} gitgutter "

" goyo {{{ "
nnoremap <silent> <leader>z :Goyo<cr>
" }}} goyo "

" gundo {{{ "
nnoremap <silent> <leader>u :GundoToggle<cr>
" }}} gundo "

" highlightedyank {{{ "
hi HighlightedyankRegion ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
" }}} highlightedyank "

" jsx {{{ "
let g:jsx_ext_required = 0
" }}} jsx "

" lion {{{ "
let b:lion_squeeze_spaces = 1
nmap <leader>a= mzglip='z
" }}} lion "

" multiple cursors {{{ "
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0
nnoremap <m--> :MultipleCursorsFind<space>
nnoremap <silent> <m-ñ>  :MultipleCursorsFind <C-R>/<CR>
xnoremap <silent> <m--> y:MultipleCursorsFind <C-R>"<CR>
xnoremap <silent> <m-ñ>  :MultipleCursorsFind <C-R>/<CR>
" }}} multiple cursors "

" neomake {{{ "
augroup neomake_commands
  autocmd!
  autocmd BufWritePost * Neomake
augroup end

let g:neomake_error_sign   = { 'text': '●', 'texthl': 'NeomakeErrorSign' }
let g:neomake_info_sign    = { 'text': '●', 'texthl': 'NeomakeInfoSign' }
let g:neomake_message_sign = { 'text': '●', 'texthl': 'NeomakeMessageSign' }
let g:neomake_warning_sign = { 'text': '●', 'texthl': 'NeomakeWarningSign' }

let g:neomake_html_enabled_makers = ['htmlhint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_flake8_args = ['--ignore', 'E402,E501']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_yaml_yamllint_args = ['-f', 'parsable']

if executable($PWD . '/node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_exe = $PWD . '/node_modules/.bin/eslint'
endif
" }}} neomake "

" netrw {{{ "
let g:netrw_altv = 1
" let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'
let g:netrw_fastbrowse = 2
" let g:netrw_list_hide = '.*\.pyc$,\.DS_Store'
let g:netrw_liststyle = 3
let g:netrw_silent = 1
let g:netrw_sort_options = 'i'
" let g:netrw_sort_sequence = '[\/]$'
let g:netrw_special_syntax = 1
let g:netrw_winsize = 25
" nnoremap <silent> <leader>k :Lexplore<cr>
" nnoremap <silent> - :Vexplore<cr>
" augroup netrw_commands
"   autocmd!
"   autocmd FileType netrw nnoremap <buffer> <c-l> <c-w>l
"   autocmd FileType netrw nmap <buffer> <c-r> <Plug>NetrwRefresh
" augroup END
" }}} netrw "

" nerdtree {{{ "
augroup nerdtree_commands
  autocmd!
  autocmd FileType nerdtree setlocal relativenumber
  autocmd FileType nerdtree nnoremap <buffer> . :<c-u> <c-r>=g:NERDTreeFileNode.GetSelected().path.str()<cr><home>
  autocmd FileType nerdtree nmap <buffer> ! .!
  autocmd FileType nerdtree nnoremap <buffer> <silent> <c-j> :TmuxNavigateDown<cr>
  autocmd FileType nerdtree nnoremap <buffer> <silent> <c-k> :TmuxNavigateUp<cr>
  autocmd FileType nerdtree nnoremap <buffer> <leader>¡ :QuickLook <c-r>=g:NERDTreeFileNode.GetSelected().path.str()<cr><cr>
augroup end

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeMinimalUI = 1
" let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowLineNumbers = 1
nnoremap <silent> - :NERDTreeFind<cr>
nnoremap <silent> <leader>k :NERDTreeToggle<cr>
" }}} nerdtree "

" peekaboo {{{ "
let g:peekaboo_delay = 750
" }}} peekaboo "

" rails {{{ "
nnoremap <silent> <leader>C :Console<cr>
nnoremap <silent> <leader>D :Start pgcli -h localhost rubicon_development<cr>
nnoremap <silent> <leader>S :Start!<cr>

augroup rails_commands
  autocmd!
  autocmd FileType ruby nnoremap <buffer> m<cr>     :Rails<cr>
  autocmd FileType ruby nnoremap <buffer> m<space>  :Rails<space>
  autocmd FileType ruby nnoremap <buffer> <leader>S :Server! -b 0.0.0.0<cr>

  " Execute line in rails runner
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sr :silent execute '!tmux send-keys -t \! rails Space runner Space "' . shellescape(getline('.')) . '" Enter'<cr>
augroup END
" }}} rails "

" rspec {{{ "
let g:rspec_command = 'Dispatch bin/rspec {spec}'
augroup ruby_commands
  autocmd!
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sf :call RunCurrentSpecFile()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>ss :call RunNearestSpec()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sl :call RunLastSpec()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sa :call RunAllSpecs()<cr>

  " Execute current spec in last pane
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>si :silent execute '!tmux send-keys -t \! rspec Space ' . shellescape(expand('%') . ':' . line(".")) . ' Enter'<cr>

  " Execute current spec file in last pane
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>so :silent execute '!tmux send-keys -t \! rspec Space ' . shellescape(expand('%')) . ' Enter'<cr>
augroup end
" }}} rspec "

" sneak {{{ "
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
" }}} sneak "

" tagbar {{{ "
let g:tagbar_compact = 1
nmap <silent> <leader>L :TagbarToggle<CR>
" }}} tagbar "

" targets {{{ "
let g:targets_pairs = '()b {}B []r <>'
" }}} targets "

" tmux navigator {{{ "
let g:tmux_navigator_save_on_switch = 1
" }}} tmux navigator "

" typescript {{{ "
augroup typescript_commands
  autocmd!
  autocmd FileType typescript nmap     <silent> <buffer> gT <leader>ht
  autocmd FileType typescript nmap     <silent> <buffer> gt <leader>vt
  autocmd FileType typescript nnoremap <silent> <buffer> T  :TSRefs<cr>
  autocmd FileType typescript nnoremap <silent> <buffer> gh :TSDoc<cr>
  autocmd FileType typescript nnoremap <silent> <buffer> t  :TSDef<cr>
augroup end

let g:nvim_typescript#signature_complete = 1
" }}} typescript "

" obsession {{{ "
nnoremap <c-s> :Obsession<cr>
" }}} obsession "

" ultisnips {{{ "
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips/']
" }}} ultisnips "

" vader {{{ "
augroup vader_commands
  au!
  autocmd FileType vader nnoremap <buffer> <leader>sf :Vader test/*<cr>
  autocmd FileType vader nnoremap <silent> <buffer> m<cr> :Vader %<cr>
  autocmd FileType vader nnoremap <silent> <buffer> m<space> :Vader %<space>
  autocmd FileType vim   nnoremap <buffer> <leader>so :source % \| echo 'sourced ' . expand("%")<cr>
  autocmd FileType vim   nnoremap <buffer> <leader>sr ggyG:@"<cr>
  autocmd FileType vim   nnoremap <buffer> <leader>ss :Vader %<cr>
  autocmd FileType vim   xnoremap <buffer> <leader>sr y:@"<cr>
augroup END
" }}} vader "

" ysurround {{{ "
nnoremap <silent> <leader>" :normal mzcs'"`z<cr>
nnoremap <silent> <leader>' :normal mzcs"'`z<cr>
" }}} ysurround "

"""""""""""""""""""""
"  Custom Commands  "
"""""""""""""""""""""
" Docker {{{ "
command! Dcup   Dispatch docker-compose up -d --remove-orphans
command! Dcps   Dispatch docker-compose ps
command! Dcstop Dispatch docker-compose stop
" }}} Docker "

" Open in Browser {{{ "
command! -nargs=? -complete=file Canary     silent call OpenInBrowser('Google Chrome Canary', <f-args>)
command! -nargs=? -complete=file Chrome     silent call OpenInBrowser('Google Chrome', <f-args>)
command! -nargs=? -complete=file Firefox    silent call OpenInBrowser('Firefox', <f-args>)
command! -nargs=? -complete=file FirefoxDev silent call OpenInBrowser('FirefoxDeveloperEdition', <f-args>)
command! -nargs=? -complete=file Safari     silent call OpenInBrowser('Safari', <f-args>)
command! -nargs=? -complete=file SafariDev  silent call OpenInBrowser('Safari Technology Preview', <f-args>)

nnoremap <silent> <leader>< :Canary<cr>
nnoremap <silent> <leader>> :Canary :9001<cr>

function! OpenInBrowser(browser, ...)
  if a:0 == 0
    let l:route = 'http://localhost:3000'
  elseif match(a:1, '^:\d\+') != -1
    " :9001 should point to http://localhost:9001
    let l:route = 'http://localhost' . a:1
  else
    let l:route = a:1
  endif

  execute '!open "' . l:route . '" -a ' . shellescape(a:browser)
endfunction
" }}} Open in Browser "

" QuickLook macOS {{{ "
command! -nargs=? -complete=file QuickLook silent call QuickLookFunction(<f-args>)
nnoremap <leader>¡ :QuickLook<cr>

function! QuickLookFunction(...)
  if a:0 == 0
    " If no files given, open current file
    let l:file = expand('%')
  else
    let l:file = a:1
  endif

  execute '!qlmanage -p ' . shellescape(l:file) . ' &> /dev/null'
endfunction
" }}} QuickLook macOS "

" Prettier {{{ "
command! -nargs=+ -complete=file Prettier silent !prettier --write <q-args>
" }}} Prettier "

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

" US ANSI layout {{{ "
" nnoremap <silent> <leader>` :Bdelete<cr>
" nnoremap <silent> <leader>~ :Bdelete!<cr>
" nnoremap <silent> <leader>§ :Bdelete<cr>
" nnoremap <silent> <leader>± :Bdelete!<cr>
" nnoremap <silent> \  :cwindow<cr>
" nnoremap <silent> \| :cclose<cr>
" nnoremap <silent> `  :bdelete<cr>
" nnoremap <silent> ~  :bdelete!<cr>
" nnoremap <silent> §  :bdelete<cr>
" nnoremap <silent> ±  :bdelete!<cr>
" }}} US ANSI layout "
