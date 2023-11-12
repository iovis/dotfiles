nnoremap g<space>  :Google<space>
nnoremap g<cr>     :Google <c-r><c-w><cr>
xnoremap g<space> y:Google <c-r>"
xnoremap g<cr>    y:Google <c-r>"<cr>

" nnoremap <silent> <leader>< :execute 'Canary ' . DotenvGet('PROJECT_URL')<cr>

command! -nargs=+ RustDocs silent call SearchIn('https://docs.rs/releases/search?query=%%QUERY%%', <q-args>)
