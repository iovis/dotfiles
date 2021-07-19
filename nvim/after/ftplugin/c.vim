" nnoremap <buffer> s<cr> :Tux make && ./%:r<cr>
" nnoremap <buffer> d<cr> :Tux make && lldb ./%:r<cr>
nnoremap <buffer> s<cr> :Tux cc -Wall -g % -o %:r && ./%:r<cr>
nnoremap <buffer> d<cr> :Tux cc -Wall -g % -o %:r && lldb ./%:r<cr>
