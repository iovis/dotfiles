tnoremap_bs = function(lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, 't', lhs, rhs, { silent = true, noremap = true })
end

nnoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true })
end

nnoremap_s = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, { silent = true, noremap = true })
end

xnoremap_s = function(lhs, rhs)
  vim.api.nvim_set_keymap('x', lhs, rhs, { silent = true, noremap = true })
end
