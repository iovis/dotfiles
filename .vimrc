scriptencoding utf-8
filetype off

call plug#begin()

Plug 'andrewradev/splitjoin.vim'
Plug 'benekastah/neomake'
Plug 'chiel92/vim-autoformat'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'iovis/browsers_castle'
Plug 'iovis/jirafa.vim'
Plug 'iovis/hubcap.vim'
Plug 'iovis/resize.vim'
Plug 'iovis/substitute.vim'
Plug 'iovis/tux.vim'
Plug 'iovis/vimlook'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vader.vim', { 'on': 'Vader', 'for': 'vader' }
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-swap'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'moll/vim-bbye'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'pbrisbin/vim-mkdir'
Plug 'raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'shougo/echodoc.vim'
Plug 'shougo/neco-vim'
Plug 'sirver/ultisnips'
Plug 'thoughtbot/vim-rspec'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-characterize'          " Use ga to see additional representations of that character
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'                " Unix helpers (:Move, :Remove...)
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'

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
set diffopt+=hiddenoff
set diffopt+=vertical
set expandtab
set foldmethod=indent
set hidden    " remember undo after quitting
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw  " Try to not draw while doing macros (helps with scrolling performance)
set linespace=2
set listchars=tab:>-,trail:-,nbsp:+,eol:$
set magic
set mouse=a
set nobackup
set nofoldenable
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
set undodir=~/.vim/undo
set virtualedit=block
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set wildignorecase
set wildmenu
set wildmode=full
let &showbreak = '└ '

if has('nvim')
  set inccommand=split

  autocmd TermOpen * startinsert
  tnoremap <c-h> <c-\><c-n><C-w>h
  tnoremap <c-j> <c-\><c-n><C-w>j
  tnoremap <c-k> <c-\><c-n><C-w>k
  tnoremap <c-l> <c-\><c-n><C-w>l
  tnoremap kj    <c-\><c-n>
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
inoremap kj <Esc>
let g:mapleader = "\<Space>"
nnoremap <space> <nop>
xnoremap <space> <nop>

" Some expansions
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
inoremap ,, <c-o>A,
inoremap ;; <c-o>A;
inoremap ,M <c-o>A-><c-f>
inoremap ,N <c-o>A=><c-f>
inoremap ,m ->
inoremap ,n =>

" QOL remappings
cnoremap <c-a> <c-b>
cnoremap <c-k> <up>
cnoremap <c-j> <down>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-O> <esc>O
inoremap <m-o> <esc>o
nmap     <s-down> ]c
nmap     <s-up>   [c
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <leader>. @@
nnoremap <leader>: @:
nnoremap <leader>e :e<space>
nnoremap <m-O> mzO<esc>`z
nnoremap <m-o> mzo<esc>`z
nnoremap Ø   mzO<esc>`z
nnoremap ø   mzo<esc>`z
nnoremap <silent> <down>  :cnext<cr>
nnoremap <silent> <left>  :lprevious<cr>
nnoremap <silent> <right> :lnext<cr>
nnoremap <silent> <up>    :cprevious<cr>
nnoremap <silent> <leader><down>  :cnfile<cr>
nnoremap <silent> <leader><left>  :lpfile<cr>
nnoremap <silent> <leader><right> :lnfile<cr>
nnoremap <silent> <leader><up>    :cpfile<cr>
nnoremap <silent> <leader>= <c-w>=
nnoremap <silent> <leader>X :qa!<cr>
nnoremap <silent> <leader>\| <c-w>\|
nnoremap <silent> <leader>_ <c-w>_
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>q :%bdelete<cr>
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>x :qa<cr>
nnoremap <silent> <leader>ª :bdelete!<cr>
nnoremap <silent> <leader>º :Bdelete!<cr>
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G
nnoremap <silent> ª :bdelete<cr>
nnoremap <silent> º :Bdelete<cr>
nnoremap # #N
nnoremap * *N
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

" Properly indent text when pasting
nnoremap p p`[v`]=
nnoremap P P`[v`]=
nnoremap gp p
nnoremap gP P

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
nmap T g]
nmap t <c-]>

nmap <silent> gT <leader>ht
nmap <silent> gt <leader>vt

nnoremap <silent> <leader>E :Dispatch! ctags<cr>

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

" nnoremap <silent> gs :<c-u>set operatorfunc=SortLinesOpFunc<cr>g@
" xnoremap <silent> gs :sort<cr>
nnoremap <silent> gr :<c-u>set operatorfunc=SortReverseLinesOpFunc<cr>g@
xnoremap <silent> gr :sort!<cr>

" Fast config editing
nnoremap <leader>us :so $MYVIMRC<cr>:echo 'vimrc sourced'<cr>
nnoremap <silent> <leader>uh :sp $MYVIMRC<cr>
nnoremap <silent> <leader>um :e! ~/.dotfiles/.vimrc_min<cr>
nnoremap <silent> <leader>up :e! .projections.json<cr>
nnoremap <silent> <leader>ut :e! ~/.tmux.conf<cr>
nnoremap <silent> <leader>uu :e! $MYVIMRC<cr>
nnoremap <silent> <leader>uv :vs $MYVIMRC<cr>
nnoremap <silent> <leader>uz :e! ~/.zshrc<cr>

" Duplicate file
nnoremap <leader>W :saveas <c-r>=fnameescape(expand('%:h')).'/'<cr>

" Scratch buffer
command! ScratchBuffer enew | setlocal buftype=nofile bufhidden=hide noswapfile
nnoremap <silent> <leader>T :ScratchBuffer<cr>

" Autocmds
augroup vimrc
  autocmd!

  " Autosave on focus lost
  autocmd FocusLost * silent! wall
  autocmd BufLeave  * silent! wall

  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup end

" Inspired by vim-unimpaired
nnoremap yo, :set relativenumber! cursorline!<cr>
nnoremap yo; :set number! relativenumber! cursorline!<cr>
nnoremap yoc :setlocal cursorline!<cr>
nnoremap yod :<c-r>=&diff ? "diffoff" : "diffthis"<cr><cr>
nnoremap yol :setlocal list!<cr>
nnoremap yon :setlocal number!<cr>
nnoremap yop :setlocal paste!<cr>
nnoremap yor :setlocal relativenumber!<cr>
nnoremap yos :setlocal spell! spelllang=en_us<cr>
nnoremap yow :setlocal wrap!<cr>

"""""""""""""""""""
" Plugin specific "
"""""""""""""""""""
" Ack {{{ "
let g:ackhighlight = 1
let g:ack_use_dispatch = 1
let g:ackprg = 'rg --vimgrep --smart-case'
nnoremap <leader>F  :Ack! ""<left>
xnoremap <leader>F y:Ack! -F "<c-r>""
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

let g:autoformat_verbosemode = 0
let g:formatters_javascript = ['prettier']
let g:formatters_json = ['prettier']
let g:formatters_ruby = ['rubocop']
" }}} autoformat "

" browsers_castle {{{ "
nnoremap g<space>  :Google<space>
nnoremap g<cr>     :execute 'Google ' . expand('<cword>')<cr>
xnoremap g<space> y:Google <c-r>"
xnoremap g<cr>    y:Google <c-r>"<cr>

nnoremap <silent> <leader>< :execute 'Canary ' . DotenvGet('PROJECT_URL')<cr>
" }}} browsers_castle "

" bufonly {{{ "
nnoremap <silent> <leader>Q :BufOnly!<cr>
" }}} bufonly "

" coc {{{ "
inoremap <silent><expr> <c-b> coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nmap     <silent> <c-t> <Plug>(coc-definition)
nnoremap <silent> <leader>lc :CocConfig<CR>
nnoremap <silent> <leader>lR :CocList -I symbols<cr>
nnoremap <silent> <leader>lp :CocList commands<cr>
nnoremap <silent> <leader>le :CocList extensions<cr>
nnoremap <silent> <leader>lr :CocList outline<cr>
nnoremap <silent> gd :call <SID>show_documentation()<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if &filetype ==? 'vim'
    execute 'h ' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
hi default CocHighlightText gui=underline
" augroup coc
"   autocmd!
"   autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup END
" }}} coc "

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
nnoremap z<cr>    :Dispatch<cr>
nnoremap z<space> :Dispatch<space>
nnoremap z!       :Dispatch!<cr>
nnoremap z?       :FocusDispatch<cr>
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
nmap <silent> <leader>-  :Gstatus<cr><c-n>

nnoremap <leader>gcc :Gcommit -m<space>
nnoremap <leader>gl  :Gpull<cr>
nnoremap <leader>gm  :Gmerge<cr>
nnoremap <leader>go  :Gread<cr>
nnoremap <leader>gpp :Gpush<cr>

nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gg :Gbrowse<cr>
nnoremap <silent> <leader>gh :silent 0Glog<cr>

xnoremap <silent> <leader>gg :Gbrowse<cr>
xnoremap <silent> <leader>gh :<c-u>silent '<,'>Glog<cr>

nnoremap <silent> <leader>gdv :Gvdiffsplit<cr>
nnoremap <silent> <leader>gdh :Ghdiffsplit<cr>
nnoremap <silent> <leader>gdm :Gdiffsplit master<cr>
" }}} fugitive "

" fzf {{{ "
set runtimepath+=/usr/local/opt/fzf

augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
  autocmd FileType fzf setlocal nornu nonu signcolumn=no
augroup end

" Don't use gitignore
command! -bang AllFiles
      \ call fzf#run(
      \   fzf#wrap(
      \     { 'source': "fd -H -I -E '.git' -E '.keep' --type file --follow --color=always" },
      \     <bang>0
      \   )
      \ )

" Make Rg not list the actual filenames
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview({ 'options': '--delimiter : --nth 4..' }, 'right:50%:hidden', 'º'),
      \   <bang>0
      \ )

" Peek Snippets
command! -bang RgSnippets
      \ call fzf#vim#grep(
      \   "rg --column --line-number --no-heading --smart-case --color=always -g'*.snippets' -g'!*undo*' . ~/.vim/",
      \   1,
      \   fzf#vim#with_preview('right:33%', 'º'),
      \   <bang>0
      \ )

nnoremap <silent> <c-p> :Commands<cr>
nnoremap <silent> <leader><leader> :Buffers<cr>
nnoremap <silent> <leader>A  :Filetypes<cr>
nnoremap <silent> <leader>H  :BCommits<cr>
nnoremap <silent> <leader>gL :Commits<cr>
nnoremap <silent> <leader>O  :AllFiles<cr>
nnoremap <silent> <leader>R  :Tags<cr>
nnoremap <silent> <leader>f  :Rg<cr>
nnoremap <silent> <leader>j  :GFiles?<cr>
nnoremap <silent> <leader>o  :Files<cr>
nnoremap <silent> <leader>r  :BTags<cr>
nnoremap <silent> <leader>sg :RgSnippets<cr>
nnoremap <silent> <leader>ñ  :BLines!<cr>
" }}} fzf "

" goyo {{{ "
nnoremap <silent> <leader>z :Goyo<cr>

" highlightedyank {{{ "
hi HighlightedyankRegion ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
" }}} highlightedyank "

" hubcap.vim {{{ "
nnoremap <leader>gco  :Gco<space>
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

" neomake {{{ "
call neomake#configure#automake('nwr', 1000)

let g:neomake_error_sign   = { 'text': '●', 'texthl': 'NeomakeErrorSign' }
let g:neomake_info_sign    = { 'text': '●', 'texthl': 'NeomakeInfoSign' }
let g:neomake_message_sign = { 'text': '●', 'texthl': 'NeomakeMessageSign' }
let g:neomake_warning_sign = { 'text': '●', 'texthl': 'NeomakeWarningSign' }

let g:neomake_html_enabled_makers = ['htmlhint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_flake8_args = ['--ignore', 'E402,E501']
let g:neomake_ruby_enabled_makers = ['rubocop', 'reek']
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
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeMinimalUI = 1
" let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowLineNumbers = 1

nnoremap <silent> - :NERDTreeFind<cr>
nnoremap <silent> <leader>k :NERDTreeToggle<cr>

augroup nerdtree_commands
  autocmd!
  autocmd FileType nerdtree setlocal relativenumber
  autocmd FileType nerdtree nnoremap <buffer> . :<c-u> <c-r>=g:NERDTreeFileNode.GetSelected().path.str()<cr><home>
  autocmd FileType nerdtree nmap     <buffer> ! .!
  autocmd FileType nerdtree nnoremap <buffer> <silent> <c-j> :TmuxNavigateDown<cr>
  autocmd FileType nerdtree nnoremap <buffer> <silent> <c-k> :TmuxNavigateUp<cr>
  autocmd FileType nerdtree xnoremap <buffer> <silent> o     :call <SID>OpenMultiple()<CR>
  autocmd FileType nerdtree xnoremap <buffer> <silent> <cr>  :call <SID>OpenMultiple()<CR>
augroup end

function! s:OpenMultiple() range
  let curLine = a:firstline

  while curLine <= a:lastline
    call cursor(curLine, 1)
    let node = g:NERDTreeFileNode.GetSelected()

    if !empty(node) && !node.path.isDirectory
      call node.open({ 'where': 'p', 'stay': 1, 'keepopen': 1 })
    endif

    let curLine += 1
  endwhile

  if g:NERDTreeQuitOnOpen
    NERDTreeClose
  endif
endfunction
" }}} nerdtree "

" obsession {{{ "
nnoremap yoo :Obsession<cr>
" }}} obsession "

" projectionist {{{ "
nnoremap <silent> <leader>aa :A<cr>
nnoremap <silent> <leader>as :AS<cr>
nnoremap <silent> <leader>av :AV<cr>

nnoremap <silent> <leader>C :Console<cr>
nnoremap <silent> <leader>S :Start!<cr>
" }}} projectionist "

" peekaboo {{{ "
let g:peekaboo_delay = 750
" }}} peekaboo "

" rails {{{ "
augroup rails_commands
  autocmd!

  " Execute line in rails runner
  autocmd FileType ruby nnoremap <buffer> <leader>sr :execute 'Rpp ' . getline('.')<cr>
augroup END
" }}} rails "

" resize.vim {{{ "
nmap <m-up>    <Plug>ResizeUp
nmap <m-down>  <Plug>ResizeDown
nmap <m-left>  <Plug>ResizeLeft
nmap <m-right> <Plug>ResizeRight
" }}} resize.vim "

" rspec {{{ "
let g:rspec_command = 'Dispatch bin/rspec {spec}'

augroup rspec_commands
  autocmd!
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sf :call RunCurrentSpecFile()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>ss :call RunNearestSpec()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sl :call RunLastSpec()<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sa :call RunAllSpecs()<cr>

  " Change rspec command to bundle exec rspec
  autocmd FileType ruby nnoremap <buffer> <leader>sb :let g:rspec_command = 'Dispatch bundle exec rspec {spec}'<cr>

  " Execute current line as a spec in last pane
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>si :execute 'Tux rspec ' . expand('%') . ':' . line('.')<cr>

  " Execute current spec file in last pane
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>so :Tux rspec %<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sp :execute 'Tux FPROF=1 FDOC=1 rspec ' . expand('%') . ':' . line('.')<cr>
  autocmd FileType ruby nnoremap <silent> <buffer> <leader>sr :Tux spring stop && rspec %<cr>
augroup end
" }}} rspec "

" signify {{{ "
let g:signify_realtime = 0
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'

" Chunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)
" }}} signify "

" sneak {{{ "
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

map f <Plug>Sneak_f
map F <Plug>Sneak_F

xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

hi Sneak      ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
hi SneakScope ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
" }}} sneak "

" swap {{{ "
let g:swap_no_default_key_mappings = 1

nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
" }}} swap "

" scriptease.vim {{{ "
nnoremap <leader>P :PP<space>

augroup scriptease_vim
  autocmd!

  autocmd FileType vim nnoremap <buffer> <leader>sb :Breakadd here<cr>
  autocmd FileType vim nnoremap <buffer> <leader>sd :Breakdel here<cr>
  autocmd FileType vim nnoremap <buffer> <leader>sl :breaklist<cr>

  autocmd FileType vim nnoremap <buffer> <leader>sc :Disarm<cr>
  autocmd FileType vim nnoremap <buffer> <leader>so :Runtime<cr>
augroup end
" }}} scriptease.vim "

" tagbar {{{ "
let g:tagbar_compact = 1
nnoremap <silent> <leader>ll :TagbarToggle<CR>
" }}} tagbar "

" targets {{{ "
let g:targets_pairs = '()b {}B []r <>'
" }}} targets "

" textobj-rubyblock {{{ "
let g:textobj_rubyblock_no_default_key_mappings = 1

xmap ad <Plug>(textobj-rubyblock-a)
omap ad <Plug>(textobj-rubyblock-a)
xmap id <Plug>(textobj-rubyblock-i)
omap id <Plug>(textobj-rubyblock-i)
" }}} textobj-rubyblock "

" tmux navigator {{{ "
let g:tmux_navigator_save_on_switch = 2
" }}} tmux navigator "

" tux.vim {{{ "
nnoremap c<space> :Tux<space>
nnoremap y<space> :Tux!<space>

" Repeat command in last tmux split
nnoremap <silent> <leader>i :Tux Up<cr>

" Execute current line
nnoremap <silent> <leader>I :silent execute 'Tux ' . getline('.')<cr>
" }}} tux.vim "

" typescript {{{ "
augroup typescript_commands
  autocmd!
  autocmd FileType typescript,typescript.tsx nmap <silent> <buffer> t  <Plug>(coc-definition)
  autocmd FileType typescript,typescript.tsx nmap <silent> <buffer> T  <Plug>(coc-references)
  autocmd FileType typescript,typescript.tsx nmap <silent> <buffer> gR <Plug>(coc-rename)
augroup end
" }}} typescript "

" ultisnips {{{ "
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips/', 'UltiSnips']

nnoremap <leader>ue :UltiSnipsEdit!<cr>
" }}} ultisnips "

" undotree {{{ "
nnoremap <silent> U :UndotreeToggle<cr>
" }}} undotree "

" vader {{{ "
augroup vader_commands
  au!
  autocmd FileType vader nnoremap <buffer> <leader>sa :Vader test/*<cr>
  autocmd FileType vader nnoremap <buffer> <leader>sf :Vader %<cr>
  autocmd FileType vader nnoremap <buffer> <leader>ss :Vader %<cr>

  autocmd FileType vim nnoremap <buffer> <leader>sa :Vader test/*<cr>
augroup END
" }}} vader "

" vimlook {{{ "
nnoremap <leader>¡ :QuickLook<space>
" }}} vimlook "

" ysurround {{{ "
nmap <leader>" mzcs'"`z
nmap <leader>' mzcs"'`z
" }}} ysurround "

"""""""""""""""""""""
"  Custom Commands  "
"""""""""""""""""""""
" Docker {{{ "
nnoremap <leader>dcu :Dcup<cr>
nnoremap <leader>dcp :Dcps<cr>
nnoremap <leader>dcs :Dcstop<cr>

command! Dcup   Dispatch! docker-compose up -d --remove-orphans
command! Dcps   Dispatch  docker-compose ps
command! Dcstop Dispatch! docker-compose stop
" }}} Docker "

" Git {{{ "
nnoremap <leader>gcb   :Gcb<space>
nnoremap <leader>gcm   :Gcm<cr>
nnoremap <leader>gcq   :Gcq<cr>
nnoremap <leader>gpsup :Gpsup<cr>
nnoremap <leader>grhh  :Grhh<cr>

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
