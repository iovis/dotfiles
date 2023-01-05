setlocal makeprg=ruby\ %

" sorbet {{{ "
" nnoremap <silent> <buffer> <leader>sr :Tux bin/tapioca gems && bin/tapioca dsl && bin/tapioca todo && bin/tapioca check-shims && bundle exec spoom bump<cr>
" nnoremap <silent> <buffer> <leader>st :e! sorbet/rbi/todo.rbi<cr>
" nnoremap <silent> <buffer> m<cr> :Tux bundle exec srb tc<cr>
"
" nnoremap <buffer> +T :e sorbet/rbi/shims/<c-r>%<cr>
" }}} sorbet "

" solargraph {{{ "
" Reset with: bundle exec solargraph clear && bundle exec yard gems --rebuild

nnoremap <silent> <buffer> <leader>sy :TuxBg! ctags && bundle exec solargraph bundle && bundle exec yard gems<cr>
nnoremap <silent> <buffer> <leader>sr :TuxBg! ctags && bundle exec solargraph clear && bundle exec solargraph download-core && bundle exec solargraph bundle && bundle exec yard gems --rebuild<cr>
" }}} solargraph "

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
