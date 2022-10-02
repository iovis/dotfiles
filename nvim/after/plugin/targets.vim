augroup targets_conf
  autocmd!
  autocmd User targets#mappings#user call targets#mappings#extend({
        \ 'r': { 'pair': [{ 'o': '[', 'c': ']' }]}
        \ })
augroup end
