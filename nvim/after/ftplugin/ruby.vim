setlocal makeprg=ruby\ %

" tags {{{ "
nmap <buffer> T g]
nmap <buffer> t <c-]>

nnoremap <silent> <buffer> <leader>E :Dispatch! ctags<cr>
" }}} tags "

" quick testing {{{ "
nnoremap <silent> <buffer> <leader>sd :TestFile --format documentation<cr>
nnoremap <silent> <buffer> <leader>sp :execute 'Tux FPROF=1 FDOC=1 rspec ' . expand('%') . ':' . line('.')<cr>

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
