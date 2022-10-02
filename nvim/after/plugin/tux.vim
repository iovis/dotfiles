nnoremap c<space> :Tux<space>
nnoremap y<space> :Tux!<space>

" Repeat command in last tmux split
nnoremap <silent> <leader>i :Tux Up<cr>

" Execute current line
nnoremap <silent> <leader>I  :silent execute 'Tux ' . escape(getline('.'), '#')<cr>
xnoremap <silent> <leader>I y:silent execute 'Tux ' . escape(getreg('0'), '#')<cr>
