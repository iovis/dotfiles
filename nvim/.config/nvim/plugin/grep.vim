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

" TODO: would it make sense in nvim v0.10 to use `cgetexpr` in an async job so
" it doesn't block the main thread?
" function! Grep(...)
" 	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
" endfunction
"
" command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)
"
" augroup quickfix
" 	autocmd!
" 	autocmd QuickFixCmdPost cgetexpr cwindow
" augroup END
