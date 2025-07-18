" config {{{ "
set nocompatible
filetype plugin indent on

if !has('g:syntax_on')
  syntax enable
endif

set autoindent
set autoread
set autowriteall
set backspace=indent,eol,start
set completeopt=menu,menuone,popup ",fuzzy
set conceallevel=0
" set cursorline
set diffopt+=hiddenoff
set diffopt+=vertical
set expandtab
set fillchars+=vert:│,diff:╱
set formatoptions-=ro  " Don't insert comment leader on new line
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linespace=2
set listchars=tab:>-,trail:-,nbsp:+,eol:$ ",lead:·
set magic
set mouse=a
set nobackup
set noruler
set nostartofline
set noswapfile
set nowrap
set nowritebackup
set number
set path=.,,**  " world's worst fuzzy finder
set relativenumber
set scrolloff=4
set shiftround
set shiftwidth=2
set shortmess-=S
set showmatch
set sidescrolloff=4
set signcolumn=yes
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
let &showbreak = '└ '
let @/ = ''  " don't show search highlights when entering or resourcing vimrc

if exists('&breakindent')
  set breakindent
endif

if has('nvim')
  set inccommand=split

  tnoremap KJ    <c-\><c-n>
  tnoremap <c-h> <c-\><c-n><C-w>h
  tnoremap <c-j> <c-\><c-n><C-w>j
  tnoremap <c-k> <c-\><c-n><C-w>k
  tnoremap <c-l> <c-\><c-n><C-w>l
else
  " Mouse support
  set ttymouse=xterm2
endif

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
" }}} config "

" bindings {{{ "
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>
let mapleader = "\<Space>"

nnoremap <space> <nop>
xnoremap <space> <nop>

" Jump to next match with TAB during a search
set wildcharm=<c-z>
cnoremap <expr> <tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<c-z>"
cnoremap <expr> <s-tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<s-tab>"

" Insert mode {{{ "
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>

inoremap <m-,> <c-o>A,
inoremap <m-.> <c-o>A.
inoremap <m-:> <c-o>A:
inoremap <m-;> <c-o>A;

inoremap <m-left> <s-left>
inoremap <m-right> <s-right>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <m-O> <esc>O
inoremap <m-o> <esc>o

inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap {<cr> {<cr>}<esc>O

inoremap (,<cr> (<cr>),<esc>O
inoremap [,<cr> [<cr>],<esc>O
inoremap {,<cr> {<cr>},<esc>O

inoremap (<space> (<space><space>)<left><left>
inoremap [<space> [<space><space>]<left><left>
inoremap {<space> {<space><space>}<left><left>
" }}} Insert mode "

" Command mode {{{ "
cnoremap <c-a> <c-b>
cnoremap <c-j> <down>
cnoremap <c-k> <up>

cnoremap <m-left> <s-left>
cnoremap <m-right> <s-right>
" }}} Command mode "

" Operator pending mode {{{ "
" Whole WORD is kinda awkward to press
onoremap ao aW
onoremap io iW
xnoremap ao aW
xnoremap io iW

" https://gist.github.com/romainl/c0a8b57a36aec71a986f1120e1931f20#file-text-objects-vim

" 24 simple text objects
" ----------------------
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" line text objects
" -----------------
" il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>

" number text object (integer and float)
" --------------------------------------
" in
function! VisualNumber()
  call search('\d\([^0-9\.]\|$\)', 'cW')
  normal v
  call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction

xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :<C-u>normal vin<CR>

" buffer text objects
" -------------------
" ie ae
xnoremap ie :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap ie :<C-u>normal vie<CR>
xnoremap ae GoggV
onoremap ae :<C-u>normal vae<CR>

" square brackets text objects
" ----------------------------
" ir ar
xnoremap ir i[
xnoremap ar a[
onoremap ir :normal vi[<CR>
onoremap ar :normal va[<CR>

" block comment text objects
" --------------------------
" i? a?
xnoremap a? [*o]*
onoremap a? :<C-u>normal va?V<CR>
xnoremap i? [*jo]*k
onoremap i? :<C-u>normal vi?V<CR>

" last change text object
" -----------------------
" ik ak
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>
" }}} Operator pending mode "

" Normal mode {{{ "
" Buffers
nnoremap <bs> <c-^>

nnoremap <leader>n <cmd>enew<cr>
nnoremap <leader>q <cmd>%bdelete<cr>
nnoremap <leader>Q <cmd>%bdelete\|e#\|bd#<cr>
nnoremap <tab>     <cmd>bp\|bd #<cr>
nnoremap <leader>b <cmd>bd!<cr>

nmap gm ;ls<cr>
nnoremap <leader>E :e<space><c-r>=fnameescape(expand('%:.:h')).'/'<cr>
nnoremap <leader>e :e<space>
nnoremap <leader>W :saveas <C-R>=fnameescape(expand('%:.:h')).'/'<cr>

" Editing
nnoremap J m`J``

nnoremap <M-j> <cmd>m+<cr>==
nnoremap <M-k> <cmd>m-2<cr>==
xnoremap <M-j> <cmd>m'>+<cr>`<my`>mzgv=gv`yo`z
xnoremap <M-k> <cmd>m'<-2<cr>`>my`<mzgv=gv`yo`z

nnoremap <m-o> m`o<esc>``
nnoremap <m-O> m`O<esc>``

nnoremap <leader>fo gg=G
nnoremap <silent> g2 :set shiftwidth=2 softtabstop=2 expandtab \| retab<cr>gg=G
nnoremap <silent> g4 :set shiftwidth=4 softtabstop=4 expandtab \| retab<cr>gg=G

xnoremap < <gv
xnoremap > >gv

" Editor
nnoremap ; :
xnoremap ; :

nnoremap <leader>w <cmd>w!<cr>
nnoremap <leader>x <cmd>confirm qa<cr>
nnoremap <leader>X <cmd>qa!<cr>

" Macros
nnoremap Q @q
xnoremap <silent> Q :norm @q<cr>

" Movement
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

noremap H g^
noremap L g$

nnoremap <s-down> ]c
nnoremap <s-up>   [c

nnoremap <c-p> <c-i>

" Panes
nnoremap <leader>v <c-w>v
nnoremap <leader>h <c-w>s

nnoremap <leader>c <c-w>c
nnoremap <leader>0 <c-w>=
nnoremap <leader>= <c-w>=

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <leader>H <c-w>H
nnoremap <leader>J <c-w>J
nnoremap <leader>K <c-w>K
nnoremap <leader>L <c-w>L

nnoremap M <c-w>o
nnoremap <leader>m <c-w>_<c-w>\|
nnoremap <leader>_ <c-w>_
nnoremap <leader>\| <c-w>\|

" Copy/Paste
nnoremap Y y$

nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
xnoremap <leader>y "+y

nnoremap p p<cmd>execute ":silent normal! `[v`]="<cr>
nnoremap P P<cmd>execute ":silent normal! `[v`]="<cr>
nnoremap gp p
nnoremap gP P
xnoremap p P
xnoremap P p

xnoremap D yP`<^

" Quickfix/Location list
nnoremap <up>   <cmd>cprevious<cr>
nnoremap <down> <cmd>cnext<cr>
nnoremap <leader><up>   <cmd>cpfile<cr>
nnoremap <leader><down> <cmd>cnfile<cr>

nnoremap <left>  <cmd>lprevious<cr>
nnoremap <right> <cmd>lnext<cr>
nnoremap <leader><left>  <cmd>lpfile<cr>
nnoremap <leader><right> <cmd>lnfile<cr>

" Repeat
nnoremap <leader>. @:
nnoremap <leader>, @@

xnoremap <silent> . :normal .<cr>

" Replace
nnoremap R ciw<c-r>0<esc>
xnoremap R "0p

" Search
noremap <silent> <leader>; :noh<cr>:echon<cr>

nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<cr>\>'<bar>set hls<cr>
nnoremap # #N

xnoremap * y:let @/=escape(@@, '/\') <bar> normal! /<cr>
xnoremap # y:let @/=escape(@@, '/\') <bar> normal! ?<cr>

" Tabs
nnoremap <m-l> <cmd>tabnext<cr>
nnoremap <m-h> <cmd>tabprevious<cr>

" nnoremap 'q <cmd>tabonly<cr>
nnoremap <leader>< <cmd>tabmove -1<cr>
nnoremap <leader>> <cmd>tabmove +1<cr>
nnoremap <leader>C <cmd>tabclose<cr>
nnoremap <leader>t <cmd>tabnew<cr>
nnoremap <leader><tab> <c-w>T
nnoremap <leader><s-tab> <cmd>tab sbuffer<cr>

" Tags
nmap T g]
nmap t <c-]>

" Toggle settings
nnoremap yol :set cursorline!<cr>
nnoremap yod :<c-r>=&diff ? "windo diffoff" : "windo diffthis"<cr><cr>
nnoremap yoh :set hlsearch!<cr>
nnoremap yoi :set list!<cr>
nnoremap yon :set number!<cr>
nnoremap yop :set paste!<cr>
nnoremap yor :set relativenumber!<cr>

nnoremap yos :setlocal spell! spelllang=en_us<cr>
nnoremap yow :setlocal wrap!<cr>
" }}} Normal mode "

" Misc {{{ "
" Global substitutions
nnoremap +g :g//<left>
nnoremap +v :v//<left>

xnoremap +g :g//<left>
xnoremap +v :v//<left>

" Undo
nmap U :undolist<cr>
" }}} Misc "
" }}} bindings "

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

" folds {{{ "
set nofoldenable

augroup folds
  autocmd!

  " Pre-set the folds to indent but allow for manual folds
  autocmd BufReadPre  * setlocal foldmethod=indent
  autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup end
" }}} folds "

" sorting {{{ "
function! SortLinesOpFunc(...)
  '[,']sort
endfunction

function! SortReverseLinesOpFunc(...)
  '[,']sort!
endfunction

nnoremap <silent> gs :<C-U>set operatorfunc=SortLinesOpFunc<CR>g@
xnoremap <silent> gs :sort<cr>
nnoremap <silent> gr :<C-U>set operatorfunc=SortReverseLinesOpFunc<CR>g@
xnoremap <silent> gr :sort!<cr>
" }}} sorting "

" grep {{{ "
command! -nargs=+ -complete=file Grep silent! grep! -r <args>|botright cwindow|redraw!

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'

nnoremap g<space>  :Grep<space>
xmap     g<space> *:Grep <c-r>=shellescape(getreg('"'), 1)<cr><space>

nmap <silent> K *:Grep "\b<cword>\b"<cr>
xmap <silent> K g<space><cr>
" }}} grep "

" ripgrep {{{ "
if executable('rg')
  command! -nargs=+ -complete=file Grep silent! grep! <args>|botright cwindow|redraw!

  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
" }}} ripgrep "

" CCR {{{ "
" Present an action for every command that returns a list
" https://gist.github.com/romainl/5b2cfb2b81f02d44e1d90b74ef555e31
function! CCR()
  let cmdline = getcmdline()

  " :filter lets you filter commands based on a pattern
  " :filt rb old => only show ruby files
  let filter_stub = '\v\C^((filt|filte|filter) .+ )*'

  command! -bar Z silent set more|delcommand Z

  if getcmdtype() !~? ':'
    return "\<CR>"
  endif

  if cmdline =~ filter_stub . '(ls|files|buffers)$'
    " like :ls but prompts for a buffer command
    return "\<CR>:b "
  elseif cmdline =~# '\v\C/(#|nu|num|numb|numbe|number|l|li|lis|list)$'
    " like :g//# but prompts for a command
    return "\<CR>:"
  elseif cmdline =~# filter_stub . '(\%)*(#|nu|num|numb|numbe|number|l|li|lis|list)$'
    " like :g//# but prompts for a command
    return "\<CR>:"
  elseif cmdline =~# '\v\C^(dli|il)'
    " like :dlist or :ilist but prompts for a count for :djump or :ijump
    return "\<CR>:" . cmdline[0] . 'j  ' . split(cmdline, ' ')[1] . "\<S-Left>\<Left>"
  elseif cmdline =~# filter_stub . '(cli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil cc\<Space>"
  elseif cmdline =~# filter_stub . '(lli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil ll\<Space>"
  elseif cmdline =~# filter_stub . 'old'
    " like :oldfiles but prompts for an old file to edit
    set nomore
    return "\<CR>:Z|e #<"
  elseif cmdline =~ filter_stub . 'changes'
    " like :changes but prompts for a change to jump to
    set nomore
    return "\<CR>:Z|norm! g;\<S-Left>"
  elseif cmdline =~ filter_stub . 'ju'
    " like :jumps but prompts for a position to jump to
    set nomore
    return "\<CR>:Z|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ filter_stub . 'marks'
    " like :marks but prompts for a mark to jump to
    return "\<CR>:norm! `"
  elseif cmdline =~# '\v\C^undol'
    " like :undolist but prompts for a change to undo
    return "\<CR>:u "
  elseif cmdline =~# '\v\C^tabs'
    set nomore
    return "\<CR>:Z| tabnext\<S-Left>"
  elseif cmdline =~# '^\k\+$'
    " handle cabbrevs gracefully
    " https://www.reddit.com/r/vim/comments/jgyqhl/nightly_hack_for_vimmers/
    return "\<C-]>\<CR>"
  elseif cmdline =~# '\C^reg'
    " Added by me!
    return "\<CR>:norm \"p\<Left>"
  else
    return "\<CR>"
  endif
endfunction

cnoremap <expr> <CR> CCR()
" }}} CCR "

" Highlights {{{ "
" nnoremap <leader>ui :execute "hi " . synIDattr(synID(line("."),col("."),1),"name")<CR>
" nnoremap +<cr> :so $VIMRUNTIME/syntax/hitest.vim<cr>
" nnoremap +<space> :hi<space>

colorscheme habamax

hi Normal guibg=NONE

hi! def link VertSplit Comment
hi! def link Tabline Comment
hi! def link TablineFill Comment
hi! def link ModeMsg Comment
hi! def link SignColumn Normal
hi! def link StatusLine Normal
hi! def link StatusLineNC Comment
hi! def link SLDirectory Directory
hi! def link SLGitBranch CursorLineNr
hi! def link SLModified Removed
hi! def link SLFileType String
" }}} Highlights "

" statusline {{{ "
function! GitBranchName() abort
  if get(b:, 'gitbranch_pwd', '') !=# expand('%:p:h') || !has_key(b:, 'gitbranch_path')
    call s:GitBranchDetect(expand('%:p:h'))
  endif

  if has_key(b:, 'gitbranch_path') && filereadable(b:gitbranch_path)
    let branch = get(readfile(b:gitbranch_path), 0, '')

    if branch =~# '^ref: '
      return '[' . substitute(branch, '^ref: \%(refs/\%(heads/\|remotes/\|tags/\)\=\)\=', '', '') . ']'
    elseif branch =~# '^\x\{20\}'
      return '[' . branch[:6] . ']'
    endif
  endif

  return ''
endfunction

function! s:GitBranchDir(path) abort
  let path = a:path
  let prev = ''

  while path !=# prev
    let dir = path . '/.git'
    let type = getftype(dir)

    if type ==# 'dir' && isdirectory(dir.'/objects') && isdirectory(dir.'/refs') && getfsize(dir.'/HEAD') > 10
      return dir
    elseif type ==# 'file'
      let reldir = get(readfile(dir), 0, '')

      if reldir =~# '^gitdir: '
        return simplify(path . '/' . reldir[8:])
      endif
    endif

    let prev = path
    let path = fnamemodify(path, ':h')
  endwhile

  return ''
endfunction

function! s:GitBranchDetect(path) abort
  unlet! b:gitbranch_path

  let b:gitbranch_pwd = expand('%:p:h')
  let dir = s:GitBranchDir(a:path)

  if dir !=# ''
    let path = dir . '/HEAD'

    if filereadable(path)
      let b:gitbranch_path = path
    endif
  endif
endfunction

augroup git_branch
  autocmd!
  autocmd BufNewFile,BufReadPost * call <SID>GitBranchDetect(expand('<amatch>:p:h'))
  autocmd BufEnter * call <SID>GitBranchDetect(expand('%:p:h'))
augroup END

function! s:RefreshStatusline()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!RenderStatuslineFor(' . nr . ')')
  endfor
endfunction

augroup status_line
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,TextChanged,InsertEnter,InsertLeave * call <SID>RefreshStatusline()
augroup END

function! RenderStatuslineFor(winnum)
  if &filetype ==# 'netrw'
    return ''
  endif

  let l:isActive = a:winnum == winnr()
  let statusline = ''

  function! s:CSL(color_group, body) closure
    if isActive
      return '%#' . a:color_group . '#' . a:body . '%*'
    else
      return a:body
    end
  endfunction

  let statusline .= s:CSL('SLDirectory', " %{expand('%:p:h:t')}") " current folder
  let statusline .= ' :: '
  let statusline .= s:CSL(&modified ? 'SLModified' : 'StatusLine', '%f%m ')  " buffer name

  let statusline .= '%='  " right side

  let statusline .= '%r '  " read-only flag
  let statusline .= s:CSL('SLGitBranch', '%{GitBranchName()} ') " branch
  let statusline .= s:CSL('SLFileType', '%{&filetype}') " filetype
  let statusline .= ' %3p%%'  " percentage in file
  " let statusline .= s:CSL('StatusLineNC', ' %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}] ') " file encoding[file format]

  return statusline
endfunction
" }}} statusline "

" tabline {{{ "
function! s:tabLineFile(bufnr)
  let file  = bufname(a:bufnr)
  let buftype = getbufvar(a:bufnr, '&buftype')

  if buftype ==? 'help'
    let file = 'help:' . fnamemodify(file, ':t:r')
  elseif buftype ==? 'quickfix'
    let file = 'quickfix'
  elseif buftype ==? 'nofile'
    if file =~? '\/.'
      let file = substitute(file, '.*\/\ze.', '', '')
    endif
  else
    let file = pathshorten(fnamemodify(file, ':p:~:.'))

    if file ==? ''
      let file = '[No Name]'
    endif

    if getbufvar(a:bufnr, '&modified')
      let file = '%#SLModified#' . file . '%*'
    endif
  endif

  return file
endfunction

function! TabLine()
  let tabline = ''
  let tab_number = tabpagenr()

  for index in range(1, tabpagenr('$'))
    let buflist = tabpagebuflist(index)
    let winnr   = tabpagewinnr(index)

    let tabline .= '%' . index . 'T'
    let tabline .= (index == tab_number ? '%#TabLineSel#' : '%#TabLine#')
    let tabline .= ' ' . index  " print tab number

    let bufnr = buflist[winnr - 1]
    let tabline .= ' ' . s:tabLineFile(bufnr)

    let window_count = tabpagewinnr(index, '$')

    if window_count > 1
      let tabline .= ' [' . window_count . ']'
    endif

    let tabline .= ' %#TabLine#|'
  endfor

  let tabline .= '%T%#TabLineFill#%='

  return tabline
endfunction

set tabline=%!TabLine()
" }}} tabline "

" netrw {{{ "
let g:netrw_altv = 1
let g:netrw_banner = 0
" let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'
" let g:netrw_list_hide = '^.*\.o/\=$,^.*\.obj/\=$,^.*\.bak/\=$,^.*\.exe/\=$,^.*\.py[co]/\=$,^.*\.swp/\=$,^.*\~/\=$,^.*\.pyc/\=$,^\.svn/\=$,^\.\.\=/\=$'
" let g:netrw_liststyle = 3
let g:netrw_silent = 1
let g:netrw_sort_options = 'i'
" let g:netrw_sort_sequence = '[\/]$,*,\%(\.bak\|\~\|\.o\|\.h\|\.info\|\.swp\|\.obj\)[*@]\=$'
let g:netrw_special_syntax = 1
let g:netrw_winsize = 25

nnoremap <silent> <leader>k :Lexplore<cr>

augroup netrw_commands
  autocmd!

  autocmd FileType netrw nnoremap <buffer> <c-l> <c-w>l
  autocmd FileType netrw nnoremap <buffer> <nowait> q <cmd>bd!<cr>

  autocmd FileType netrw nmap     <buffer> <c-s> <Plug>NetrwRefresh
  autocmd FileType netrw nmap     <buffer> a     <Plug>NetrwOpenFile
  autocmd FileType netrw nmap     <buffer> g.    <Plug>NetrwHide_a
augroup END
" }}} netrw "

" Filetypes {{{ "
augroup ruby_commands
  autocmd!
  autocmd FileType ruby setlocal commentstring=#%s makeprg=ruby\ %
augroup end

augroup python_commands
  autocmd!
  autocmd FileType python setlocal commentstring=#%s shiftwidth=4 softtabstop=4 makeprg=python\ %
augroup end

augroup javascript_commands
  autocmd!
  autocmd FileType javascript setlocal commentstring=//%s
augroup end

augroup vim_commands
  autocmd!
  autocmd FileType vim setlocal commentstring=\"%s foldmethod=marker
augroup end

augroup zsh_commands
  autocmd!
  autocmd FileType zsh setlocal commentstring=#%s
augroup end
" }}} Filetypes "

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

nnoremap <silent>  \ :call ToggleList("Quickfix List", 'c')<cr>
nnoremap <silent> \| :call ToggleList("Location List", 'l')<cr>
" }}} QuickFix toggle "

" External Plugins {{{ "
" commentary.vim {{{ "
" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists('g:loaded_commentary') || v:version < 700
  finish
endif
let g:loaded_commentary = 1

function! s:surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! s:strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if l[-1:] ==# ' ' && stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0
    let l = l[:-2]
  endif
  if r[0] ==# ' ' && a:line[-strlen(r):] != r && a:line[1-strlen(r):] == r[1:]
    let r = r[1:]
  endif
  return [l, r]
endfunction

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l, r] = s:surroundings()
  let uncomment = 2
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = s:strip_white_space(l,r,line)
    if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M'.r[0:-2].'\zs\d\*\ze'.r[-1:-1].'\|'.l[0].'\zs\d\*\ze'.l[1:-1],
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),'^\s*').'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call setline(lnum,line)
  endfor
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
  return ''
endfunction

function! s:textobject(inner) abort
  let [l, r] = s:surroundings()
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = s:strip_white_space(l,r,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

command! -range -bar Commentary call s:go(<line1>,<line2>)
xnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  if maparg('c','n') ==# '' && !exists('v:operator')
    nmap cgc <Plug>ChangeCommentary
  endif
  nmap gcu <Plug>Commentary<Plug>Commentary
endif
" }}} commentary.vim "

" resize.vim {{{ "
nmap <m-up>    <Plug>ResizeUp
nmap <m-down>  <Plug>ResizeDown
nmap <m-left>  <Plug>ResizeLeft
nmap <m-right> <Plug>ResizeRight

if exists('g:resize_vim_loaded') || &compatible || v:version < 700
  finish
endif
let g:resize_vim_loaded = 1
let g:resize_vim_vertical = 3
let g:resize_vim_horizontal = 6

noremap <silent> <unique> <Plug>ResizeUp    :call Resize_up()<cr>
noremap <silent> <unique> <Plug>ResizeDown  :call Resize_down()<cr>
noremap <silent> <unique> <Plug>ResizeLeft  :call Resize_left()<cr>
noremap <silent> <unique> <Plug>ResizeRight :call Resize_right()<cr>

function! Resize_up() abort
  let l:sign = Resize_is_edge('j') ? '+' : '-'
  silent! execute 'resize ' . l:sign . g:resize_vim_vertical
endfunction

function! Resize_down() abort
  let l:sign = Resize_is_edge('j') ? '-' : '+'
  silent! execute 'resize ' . l:sign . g:resize_vim_vertical
endfunction

function! Resize_left() abort
  let l:sign = Resize_is_edge('l') ? '+' : '-'
  silent! execute 'vertical resize ' . l:sign . g:resize_vim_horizontal
endfunction

function! Resize_right() abort
  let l:sign = Resize_is_edge('l') ? '-' : '+'
  silent! execute 'vertical resize ' . l:sign . g:resize_vim_horizontal
endfunction

function! Resize_is_edge(direction) abort
  let l:current_window = winnr()
  silent! execute 'wincmd ' . a:direction

  let l:edge_window = winnr()
  silent! execute l:current_window . 'wincmd w'

  return l:current_window == l:edge_window
endfunction
" }}} resize.vim "

" vim-vinegar {{{ "
" Location:     plugin/vinegar.vim
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 5671 1 :AutoInstall: vinegar.vim

if exists('g:loaded_vinegar') || v:version < 700 || &cp
  finish
endif
let g:loaded_vinegar = 1

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'

let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let g:netrw_list_hide =
      \ join(map(split(&wildignore, ','), '"^".' . s:escape . '. "/\\=$"'), ',') . ',^\.\.\=/\=$' .
      \ (get(g:, 'netrw_list_hide', '')[-strlen(s:dotfiles)-1:-1] ==# s:dotfiles ? ','.s:dotfiles : '')
if !exists('g:netrw_banner')
  let g:netrw_banner = 0
endif
unlet! s:netrw_up

nnoremap <silent> <Plug>VinegarUp :call <SID>opendir('edit')<CR>
if empty(maparg('-', 'n'))
  nmap - <Plug>VinegarUp
endif

nnoremap <silent> <Plug>VinegarTabUp :call <SID>opendir('tabedit')<CR>
nnoremap <silent> <Plug>VinegarSplitUp :call <SID>opendir('split')<CR>
nnoremap <silent> <Plug>VinegarVerticalSplitUp :call <SID>opendir('vsplit')<CR>

function! s:opendir(cmd) abort
  let df = ','.s:dotfiles
  if expand('%:t')[0] ==# '.' && g:netrw_list_hide[-strlen(df):-1] ==# df
    let g:netrw_list_hide = g:netrw_list_hide[0 : -strlen(df)-1]
  endif
  if &filetype ==# 'netrw' && len(s:netrw_up)
    let basename = fnamemodify(b:netrw_curdir, ':t')
    execute s:netrw_up
    call s:seek(basename)
  elseif expand('%') =~# '^$\|^term:[\/][\/]'
    execute a:cmd '.'
  else
    execute a:cmd '%:h'
    call s:seek(expand('#:t'))
  endif
endfunction

function! s:seek(file) abort
  if get(b:, 'netrw_liststyle') == 2
    let pattern = '\%(^\|\s\+\)\zs'.escape(a:file, '.*[]~\').'[/*|@=]\=\%($\|\s\+\)'
  else
    let pattern = '^\%(| \)*'.escape(a:file, '.*[]~\').'[/*|@=]\=\%($\|\t\)'
  endif
  call search(pattern, 'wc')
  return pattern
endfunction

augroup vinegar
  autocmd!
  autocmd FileType netrw call s:setup_vinegar()
augroup END

function! s:slash() abort
  return !exists('+shellslash') || &shellslash ? '/' : '\'
endfunction

function! s:absolutes(first, ...) abort
  let files = getline(a:first, a:0 ? a:1 : a:first)
  call filter(files, 'v:val !~# "^\" "')
  call map(files, "substitute(v:val, '^\\(| \\)*', '', '')")
  call map(files, 'b:netrw_curdir . s:slash() . substitute(v:val, "[/*|@=]\\=\\%(\\t.*\\)\\=$", "", "")')
  return files
endfunction

function! s:relatives(first, ...) abort
  let files = s:absolutes(a:first, a:0 ? a:1 : a:first)
  call filter(files, 'v:val !~# "^\" "')
  for i in range(len(files))
    let relative = fnamemodify(files[i], ':.')
    if relative !=# files[i]
      let files[i] = '.' . s:slash() . relative
    endif
  endfor
  return files
endfunction

function! s:escaped(first, last) abort
  let files = s:relatives(a:first, a:last)
  return join(map(files, 's:fnameescape(v:val)'), ' ')
endfunction

function! s:setup_vinegar() abort
  if !exists('s:netrw_up')
    let orig = maparg('-', 'n')
    if orig =~? '^<plug>'
      let s:netrw_up = 'execute "normal \'.substitute(orig, ' *$', '', '').'"'
    elseif orig =~# '^:'
      " :exe "norm! 0"|call netrw#LocalBrowseCheck(<SNR>123_NetrwBrowseChgDir(1,'../'))<CR>
      let s:netrw_up = substitute(orig, '\c^:\%(<c-u>\)\=\|<cr>$', '', 'g')
    else
      let s:netrw_up = ''
    endif
  endif
  nmap <buffer> - <Plug>VinegarUp
  cnoremap <buffer><expr> <Plug><cfile> get(<SID>relatives('.'),0,"\022\006")
  if empty(maparg('<C-R><C-F>', 'c'))
    cmap <buffer> <C-R><C-F> <Plug><cfile>
  endif
  nnoremap <buffer> ~ :edit ~/<CR>
  nnoremap <buffer> . :<C-U> <C-R>=<SID>escaped(line('.'), line('.') - 1 + v:count1)<CR><Home>
  xnoremap <buffer> . <Esc>: <C-R>=<SID>escaped(line("'<"), line("'>"))<CR><Home>
  if empty(mapcheck('y.', 'n'))
    nnoremap <silent><buffer> y. :<C-U>call setreg(v:register, join(<SID>absolutes(line('.'), line('.') - 1 + v:count1), "\n")."\n")<CR>
  endif
  nmap <buffer> ! .!
  xmap <buffer> ! .!
  let g:netrw_sort_sequence = '[\/]$,*' . (empty(&suffixes) ? '' : ',\%(' .
        \ join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$')
  exe 'syn match netrwSuffixes =\%(\S\+ \)*\S\+\%('.join(map(split(&suffixes, ','), s:escape), '\|') . '\)[*@]\=\S\@!='
  hi def link netrwSuffixes SpecialKey
endfunction
" }}} vim-vinegar "

" vim-oscyank {{{ "
nmap <leader>y <Plug>OSCYank
nnoremap <leader>Y v$:OSCYank<cr>
nnoremap <leader>yy V:OSCYank<cr>
xnoremap <leader>y :OSCYank<cr>

let g:oscyank_term = 'default'

" vim-oscyank
" Author: Olivier Roques

if exists('g:loaded_oscyank') || &compatible
  finish
endif

let g:loaded_oscyank = 1

" Send a string to the terminal's clipboard using OSC52.
function! OSCYankString(str)
  let length = strlen(a:str)
  let limit = get(g:, 'oscyank_max_length', 100000)
  let osc52_key = 'default'

  if length > limit
    echohl WarningMsg
    echo '[oscyank] Selection has length ' . length . ', limit is ' . limit
    echohl None
    return
  endif

  if exists('g:oscyank_term')  " Explicitly use a supported terminal.
    let osc52_key = get(g:, 'oscyank_term')
  else  " Fallback to auto-detection.
    if !empty($TMUX)
      let osc52_key = 'tmux'
    elseif match($TERM, 'screen') > -1
      let osc52_key = 'screen'
    elseif match($TERM, 'kitty') > -1
      let osc52_key = 'kitty'
    endif
  endif

  let osc52 = get(s:osc52_table, osc52_key, s:osc52_table['default'])(a:str)
  call s:raw_echo(osc52)

  if !get(g:, 'oscyank_silent', 0)
    echo '[oscyank] ' . length . ' characters copied'
  endif
endfunction

" Send the visual selection to the terminal's clipboard using OSC52.
" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! OSCYankVisual() range
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]

  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif

  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]

  call OSCYankString(join(lines, "\n"))
  execute "normal! `<"
endfunction

" Send the input text object to the terminal's clipboard using OSC52.
function! OSCYankOperator(type, ...) abort
  " Special case: if the user _has_ explicitly specified a register (or
  " they've just supplied one of the possible defaults), OSCYank its contents.
  if !(v:register ==# '"' || v:register ==# '*' || v:register ==# '+')
    call OSCYankString(getreg(v:register))
    return ''
  endif

  " Otherwise, do the usual operator dance (see `:help g@`).
  if a:type == ''
    set opfunc=OSCYankOperator
    return 'g@'
  endif

  let [line_start, column_start] = getpos("'[")[1:2]
  let [line_end, column_end] = getpos("']")[1:2]

  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif

  if a:type ==# "char"
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
  endif

  call OSCYankString(join(lines, "\n"))
endfunction

" This function base64's the entire string and wraps it in a single OSC52.
" It's appropriate when running in a raw terminal that supports OSC 52.
function! s:get_OSC52(str)
  let b64 = s:b64encode(a:str, 0)
  return "\e]52;c;" . b64 . "\x07"
endfunction

" This function base64's the entire string and wraps it in a single OSC52 for
" tmux.
" This is for `tmux` sessions which filters OSC52 locally.
function! s:get_OSC52_tmux(str)
  let b64 = s:b64encode(a:str, 0)
  return "\ePtmux;\e\e]52;c;" . b64 . "\x07\e\\"
endfunction

" This function base64's the entire source, wraps it in a single OSC52, and then
" breaks the result into small chunks which are each wrapped in a DCS sequence.
" This is appropriate when running on `screen`. Screen doesn't support OSC52,
" but will pass the contents of a DCS sequence to the outer terminal unchanged.
" It imposes a small max length to DCS sequences, so we send in chunks.
function! s:get_OSC52_DCS(str)
  let b64 = s:b64encode(a:str, 76)
  " Remove the trailing newline.
  let b64 = substitute(b64, '\n*$', '', '')
  " Replace each newline with an <end-dcs><start-dcs> pair.
  let b64 = substitute(b64, '\n', "\e/\eP", "g")
  " (except end-of-dcs is "ESC \", begin is "ESC P", and I can't figure out
  " how to express "ESC \ ESC P" in a single string. So the first substitute
  " uses "ESC / ESC P" and the second one swaps out the "/". It seems like
  " there should be a better way.)
  let b64 = substitute(b64, '/', '\', 'g')
  " Now wrap the whole thing in <start-dcs><start-osc52>...<end-osc52><end-dcs>.
  return "\eP\e]52;c;" . b64 . "\x07\e\x5c"
endfunction

" Kitty versions below 0.22.0 require the clipboard to be flushed before
" accepting a new string.
" https://sw.kovidgoyal.net/kitty/changelog/#id33
function! s:get_OSC52_kitty(str)
  call s:raw_echo("\e]52;c;!\x07")
  return s:get_OSC52(a:str)
endfunction

" Echo a string to the terminal without munging the escape sequences.
function! s:raw_echo(str)
  if has('win32') && has('nvim')
    call chansend(v:stderr, a:str)
  else
    if filewritable('/dev/fd/2')
      call writefile([a:str], '/dev/fd/2', 'b')
    else
      exec("silent! !echo " . shellescape(a:str))
      redraw!
    endif
  endif
endfunction

" Encode a string of bytes in base 64.
" If size is > 0 the output will be line wrapped every `size` chars.
function! s:b64encode(str, size)
  let bytes = s:str2bytes(a:str)
  let b64_arr = []

  for i in range(0, len(bytes) - 1, 3)
    let n = bytes[i] * 0x10000
          \ + get(bytes, i + 1, 0) * 0x100
          \ + get(bytes, i + 2, 0)
    call add(b64_arr, s:b64_table[n / 0x40000])
    call add(b64_arr, s:b64_table[n / 0x1000 % 0x40])
    call add(b64_arr, s:b64_table[n / 0x40 % 0x40])
    call add(b64_arr, s:b64_table[n % 0x40])
  endfor

  if len(bytes) % 3 == 1
    let b64_arr[-1] = '='
    let b64_arr[-2] = '='
  endif

  if len(bytes) % 3 == 2
    let b64_arr[-1] = '='
  endif

  let b64 = join(b64_arr, '')
  if a:size <= 0
    return b64
  endif

  let chunked = ''
  while strlen(b64) > 0
    let chunked .= strpart(b64, 0, a:size) . "\n"
    let b64 = strpart(b64, a:size)
  endwhile

  return chunked
endfunction

function! s:str2bytes(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

" Lookup table for g:oscyank_term.
let s:osc52_table = {
      \ 'default': function('s:get_OSC52'),
      \ 'kitty': function('s:get_OSC52_kitty'),
      \ 'screen': function('s:get_OSC52_DCS'),
      \ 'tmux': function('s:get_OSC52_tmux'),
      \ }

" Lookup table for s:b64encode.
let s:b64_table = [
      \ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
      \ "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
      \ "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
      \ "w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/",
      \ ]

nnoremap <silent> <expr> <Plug>OSCYank OSCYankOperator('')

command! -range OSCYank <line1>,<line2>call OSCYankVisual()
command! -nargs=1 OSCYankReg call OSCYankString(getreg(<f-args>))
" }}} vim-oscyank "

" vim-tmux-navigator {{{ "
" Maps <C-h/j/k/l> to switch vim splits in the given direction. If there are
" no more windows in that direction, forwards the operation to tmux.
" Additionally, <C-\> toggles between last active vim splits/tmux panes.

if exists('g:loaded_tmux_navigator') || &cp || v:version < 700
  finish
endif
let g:loaded_tmux_navigator = 1

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

if !get(g:, 'tmux_navigator_no_mappings', 0)
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
endif

if empty($TMUX)
  command! TmuxNavigateLeft call s:VimNavigate('h')
  command! TmuxNavigateDown call s:VimNavigate('j')
  command! TmuxNavigateUp call s:VimNavigate('k')
  command! TmuxNavigateRight call s:VimNavigate('l')
  command! TmuxNavigatePrevious call s:VimNavigate('p')
  finish
endif

command! TmuxNavigateLeft call s:TmuxAwareNavigate('h')
command! TmuxNavigateDown call s:TmuxAwareNavigate('j')
command! TmuxNavigateUp call s:TmuxAwareNavigate('k')
command! TmuxNavigateRight call s:TmuxAwareNavigate('l')
command! TmuxNavigatePrevious call s:TmuxAwareNavigate('p')

if !exists('g:tmux_navigator_save_on_switch')
  let g:tmux_navigator_save_on_switch = 0
endif

if !exists('g:tmux_navigator_disable_when_zoomed')
  let g:tmux_navigator_disable_when_zoomed = 0
endif

if !exists('g:tmux_navigator_preserve_zoom')
  let g:tmux_navigator_preserve_zoom = 0
endif

function! s:TmuxOrTmateExecutable()
  return (match($TMUX, 'tmate') != -1 ? 'tmate' : 'tmux')
endfunction

function! s:TmuxVimPaneIsZoomed()
  return s:TmuxCommand("display-message -p '#{window_zoomed_flag}'") == 1
endfunction

function! s:TmuxSocket()
  " The socket path is the first value in the comma-separated list of $TMUX.
  return split($TMUX, ',')[0]
endfunction

function! s:TmuxCommand(args)
  let cmd = s:TmuxOrTmateExecutable() . ' -S ' . s:TmuxSocket() . ' ' . a:args
  let l:x=&shellcmdflag
  let &shellcmdflag='-c'
  let retval=system(cmd)
  let &shellcmdflag=l:x
  return retval
endfunction

function! s:TmuxNavigatorProcessList()
  echo s:TmuxCommand("run-shell 'ps -o state= -o comm= -t ''''#{pane_tty}'''''")
endfunction
command! TmuxNavigatorProcessList call s:TmuxNavigatorProcessList()

let s:tmux_is_last_pane = 0
augroup tmux_navigator
  au!
  autocmd WinEnter * let s:tmux_is_last_pane = 0
augroup END

function! s:NeedsVitalityRedraw()
  return exists('g:loaded_vitality') && v:version < 704 && !has('patch481')
endfunction

function! s:ShouldForwardNavigationBackToTmux(tmux_last_pane, at_tab_page_edge)
  if g:tmux_navigator_disable_when_zoomed && s:TmuxVimPaneIsZoomed()
    return 0
  endif
  return a:tmux_last_pane || a:at_tab_page_edge
endfunction

function! s:TmuxAwareNavigate(direction)
  let nr = winnr()
  let tmux_last_pane = (a:direction ==? 'p' && s:tmux_is_last_pane)
  if !tmux_last_pane
    call s:VimNavigate(a:direction)
  endif
  let at_tab_page_edge = (nr == winnr())
  " Forward the switch panes command to tmux if:
  " a) we're toggling between the last tmux pane;
  " b) we tried switching windows in vim but it didn't have effect.
  if s:ShouldForwardNavigationBackToTmux(tmux_last_pane, at_tab_page_edge)
    if g:tmux_navigator_save_on_switch == 1
      try
        update " save the active buffer. See :help update
      catch /^Vim\%((\a\+)\)\=:E32/ " catches the no file name error
      endtry
    elseif g:tmux_navigator_save_on_switch == 2
      try
        wall " save all the buffers. See :help wall
      catch /^Vim\%((\a\+)\)\=:E141/ " catches the no file name error
      endtry
    endif
    let args = 'select-pane -t ' . shellescape($TMUX_PANE) . ' -' . tr(a:direction, 'phjkl', 'lLDUR')
    if g:tmux_navigator_preserve_zoom == 1
      let l:args .= ' -Z'
    endif
    silent call s:TmuxCommand(args)
    if s:NeedsVitalityRedraw()
      redraw!
    endif
    let s:tmux_is_last_pane = 1
  else
    let s:tmux_is_last_pane = 0
  endif
endfunction
" }}} vim-tmux-navigator "
" }}} External Plugins "
