command! -nargs=+ -complete=file_in_path Grep silent! grep! <args>|botright cwindow

if executable('rg')
  set grepprg=rg\ --hidden\ --vimgrep\ --smart-case\ -g\ '!Session.vim'\ -g\ '!.git'
  set grepformat=%f:%l:%c:%m
endif

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'

nnoremap <leader>fs  :Grep<space>
xmap     <leader>fs *:Grep -F <c-r>=shellescape(getreg('"'), 1)<cr><space>

nmap <silent> K *:Grep -w <cword><cr>
xmap <silent> K <leader>fs<cr>
