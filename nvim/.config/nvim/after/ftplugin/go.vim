setlocal tabstop=4

nmap <silent> <buffer> s<cr> :Tux go run %<cr>

augroup lsp_document_format
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
augroup end
