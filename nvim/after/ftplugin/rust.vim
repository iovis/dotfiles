setlocal shiftwidth=4
setlocal softtabstop=4

nmap <silent> <buffer> m<cr> :Tux cargo check --all-targets<cr>
nmap <silent> <buffer> s<cr> :Tux cargo run<cr>

nnoremap <buffer> <leader>sr :RustReloadWorkspace<cr>
nnoremap <buffer> <leader>sp :TestNearest -strategy=rust_log<cr>
