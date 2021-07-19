setlocal makeprg=ruby\ %

" tags {{{ "
nmap <buffer> T g]
nmap <buffer> t <c-]>

nnoremap <silent> <buffer> <leader>E :Dispatch! ctags<cr>
" }}} tags "

" quick testing {{{ "
" Change rspec command to bundle exec rspec
nnoremap <buffer> <leader>sb :let g:rspec_command = 'Dispatch bundle exec rspec {spec}'<cr>

" Execute current line as a spec in last pane
nnoremap <silent> <buffer> <leader>si :execute 'Tux rspec ' . expand('%') . ':' . line('.')<cr>

" Execute current spec file in last pane
nnoremap <silent> <buffer> <leader>so :Tux rspec %<cr>
nnoremap <silent> <buffer> <leader>sd :Tux rspec --format documentation %<cr>
nnoremap <silent> <buffer> <leader>sp :execute 'Tux FPROF=1 FDOC=1 rspec ' . expand('%') . ':' . line('.')<cr>
nnoremap <silent> <buffer> <leader>sr :Tux spring stop && rspec %<cr>

" Load failing tests in a scratch window
nmap +R :Redir !cat tmp/rspec-failures.txt<cr>
      \ :g/\(passed\\|pending\)/d<cr>
      \ :v/spec/d<cr>
      \ :%s/\[\d.*<cr>
      \ :sort u<cr>
      \ :%norm! Irspec <cr>
" }}} quick testing "

" rails {{{ "
" Execute line in rails runner
nnoremap <buffer> <leader>sr :execute 'Rpp ' . getline('.')<cr>
nnoremap <buffer> <leader>P  :Rpp<space>
" }}} rails "
