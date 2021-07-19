" Options {{{ "
setlocal conceallevel=2
setlocal spelllang=en_us
setlocal spell
setlocal shiftwidth=4
setlocal softtabstop=4
" }}} Options "

" Formatting {{{ "
setlocal formatoptions+=tcoqnl1j
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
