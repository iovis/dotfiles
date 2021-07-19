setlocal shiftwidth=4
setlocal softtabstop=4

" run standalone file (should probably change this, tbh)
nmap <silent> <buffer> s<cr> :Tux rust %<cr>
