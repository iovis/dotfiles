command! -nargs=+ -complete=file Grep silent! grep! -R <args>|botright cwindow|redraw!

nnoremap <leader>F  :Grep ""<left>
xmap     <leader>F *:<c-u>Grep "<c-r>""

nmap <silent> K *:Grep -w "<cword>"<cr>
xmap <silent> K *:Grep -F "<c-r>""<cr>

if executable('rg')
  command! -nargs=+ -complete=file Grep silent! grep! <args>|botright cwindow|redraw!

  set grepprg=rg\ --hidden\ --vimgrep\ --smart-case\ -g\ '!Session.vim'\ -g\ '!.git'
  set grepformat=%f:%l:%c:%m
endif
