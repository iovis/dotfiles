" Options {{{ "
setlocal conceallevel=2
setlocal spelllang=en_us
setlocal spell
setlocal shiftwidth=4
setlocal softtabstop=4
" }}} Options "

" Formatting {{{ "
setlocal formatoptions+=tcroqnl1j
setlocal comments=b:*,b:-,b:+,b:?,n:>

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

nmap <buffer> <silent> X <Plug>ToggleCheckbox
xmap <buffer> <silent> X :call ToggleCheckbox()<cr>

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
