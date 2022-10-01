---- Auto create intermediate directories if they don't exist
vim.api.nvim_create_augroup("autocreate_dir", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = "autocreate_dir",
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})
