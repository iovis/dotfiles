nnoremap c<space> :Tux<space>
nnoremap y<space> :TuxBg<space>
nnoremap s<space> :TuxBg!<space>

nnoremap <leader>lg :TuxBg lazygit<cr>

" Repeat command in last tmux split
nnoremap <silent> <leader>i :Tux Up<cr>

" Execute current line
nnoremap <silent> <leader>I  :silent execute 'Tux ' . escape(getline('.'), '#%')<cr>
xnoremap <silent> <leader>I y:silent execute 'Tux ' . escape(getreg('0'), '#%')<cr>

" Quick open project
nnoremap <silent> +C :Tux! f && clear<cr>
nnoremap <silent> +V :Tux! vim_plugins && clear<cr>

" Docker {{{ "
" nnoremap <leader>dcp :Dcps<cr>
" nnoremap <leader>dcs :Dcstop<cr>
" nnoremap <leader>dcu :Dcup<cr>

command! Dcps   TuxBg docker compose ps | less
command! Dcstop TuxBg! docker compose stop
command! Dcup   TuxBg! docker compose up -d --remove-orphans
" }}} Docker "
