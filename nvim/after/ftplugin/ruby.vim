setlocal makeprg=ruby\ %

" sorbet {{{ "
" nnoremap <silent> <leader>E :Tux RUBYOPT="-W0" bin/tapioca gems && RUBYOPT="-W0" bundle exec rails rails_rbi:all && RUBYOPT="-W0" bundle exec spoom bump<cr>
" nnoremap <silent> <buffer> <leader>E :Tux RUBYOPT="-W0" bin/tapioca gems && RUBYOPT="-W0" bin/tapioca dsl && RUBYOPT="-W0" bin/tapioca todo && RUBYOPT="-W0" bundle exec spoom bump<cr>
" nnoremap <silent> <buffer> m<cr> :Tux bundle exec srb tc<cr>
"
" nnoremap <buffer> +T :e sorbet/rbi/<c-r>%<cr>
" }}} sorbet "

" quick testing {{{ "
nnoremap <silent> <buffer> <leader>sd :TestFile --format documentation<cr>
nnoremap <silent> <buffer> <leader>sp :TestNearest -strategy=test_prof<cr>

" Load failing tests in a scratch window
nmap <silent> <buffer> +R :Redir !cat tmp/rspec-failures.txt<cr>
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
