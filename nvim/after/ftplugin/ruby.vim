setlocal makeprg=ruby\ %

" quick testing {{{ "
nnoremap <silent> <buffer> <leader>sd :TestFile --format documentation<cr>
nnoremap <silent> <buffer> <leader>sp :TestNearest -strategy=test_prof<cr>

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
