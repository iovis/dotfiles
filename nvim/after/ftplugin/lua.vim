nnoremap <buffer> <leader>so :source %<cr>

augroup lsp_document_format
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
augroup end
