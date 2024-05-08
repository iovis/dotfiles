---- package.json
if vim.fn.expand("%"):match("package.json") then
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check Node dependencies",
    group = vim.api.nvim_create_augroup("node_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      require("config.hooks.dependencies").run("npm")
    end,
  })
end

vim.keymap.set("n", "'J", ":silent %!jq ''<left>")
vim.keymap.set("n", "'F", ":R !jq ''<left> %")
