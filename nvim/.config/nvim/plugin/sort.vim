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
