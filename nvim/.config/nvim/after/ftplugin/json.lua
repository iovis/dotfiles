---- package.json
if vim.fn.expand("%"):match("package.json") then
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check Node dependencies",
    group = vim.api.nvim_create_augroup("node_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = require("config.hooks.npm").run,
  })
end
