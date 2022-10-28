nnoremap <buffer> <leader>so :source %<cr>

nnoremap <leader>P :lua<space>=

augroup lsp_document_format
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
augroup end
