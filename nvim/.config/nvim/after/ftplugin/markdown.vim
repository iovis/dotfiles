" Options {{{ "
setlocal conceallevel=2
setlocal spelllang=en_us
setlocal spell
setlocal shiftwidth=4
setlocal softtabstop=4
" }}} Options "

" Formatting {{{ "
setlocal formatoptions+=tcroqnl1jp

" Allow *, -, +, ?, > to auto create the character on line change
setlocal comments=b:*,b:-,b:+,b:?,n:>

" Better indention/hierarchy (:h fo-n)
"
" Example:
" 1. the first item
"    wraps
" 2. the second item
setlocal formatlistpat=^\\s*                    " Optional leading whitespace
setlocal formatlistpat+=[                       " Start class
setlocal formatlistpat+=\\[({]\\?               " |  Optionally match opening punctuation
setlocal formatlistpat+=\\(                     " |  Start group
setlocal formatlistpat+=[0-9]\\+                " |  |  A number
setlocal formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+ " |  |  Roman numerals
setlocal formatlistpat+=\\\|[a-zA-Z]            " |  |  A single letter
setlocal formatlistpat+=\\)                     " |  End group
setlocal formatlistpat+=[\\]:.)}                " |  Closing punctuation
setlocal formatlistpat+=]                       " End class
setlocal formatlistpat+=\\s\\+                  " One or more spaces
setlocal formatlistpat+=\\\|^\\s*[-–+o*]\\s\\+  " Or ASCII style bullet points
" }}} Formatting "

" Bindings {{{ "
inoremap <buffer> [ []<left>
inoremap <buffer> [<space> [ ]<space>
inoremap <buffer> [<cr> [<cr>]<esc>O

nnoremap <buffer> m<space> :Move<space>

" change bullet point style {{{ "
nnoremap <buffer> <leader>* mz^r*`z
nnoremap <buffer> <leader>? mz^r?`z
nnoremap <buffer> <leader>+ mz^r+`z
nnoremap <buffer> <leader>- mz^r-`z
" }}} change bullet point style "

" strike-through line {{{ "
nmap     <buffer> <leader>ñ mzyss~`z
xnoremap <buffer> <leader>ñ :norm yss~<cr>
" }}} strike-through line "
" }}} Bindings "

" functions {{{ "
" Repeatable toggle checkbox
nnoremap <buffer> <silent> <Plug>ToggleCheckbox
      \ :call ToggleCheckbox()<bar>
      \  call repeat#set("\<Plug>ToggleCheckbox")<cr>

nmap <buffer> <silent> yox <Plug>ToggleCheckbox
" xmap <buffer> <silent> yox :call ToggleCheckbox()<cr>  --> makes yank slow :(

function! ToggleCheckbox()
  let line = getline('.')

  if line =~# '- \[ \]'
    let line = substitute(line, '- \[ \]', '- \[x\]', '')
  elseif line =~# '- \[x\]'
    let line = substitute(line, '- \[x\]', '- \[ \]', '')
  endif

  call setline('.', line)
endfunction
" }}} functions "
