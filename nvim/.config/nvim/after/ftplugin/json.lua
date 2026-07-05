local u = require("config.utils")

---- package.json
if u.current_file() == "package.json" then
  if vim.g.custom_hooks then
    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      desc = "Check Node dependencies",
      group = vim.api.nvim_create_augroup("node_dependencies", { clear = true }),
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        require("config.hooks.dependencies").run("npm")
      end,
    })
  end
end

vim.keymap.set("n", "'J", ":silent %!jq '.'<left>", { buf = 0 })
vim.keymap.set("n", "'f", ":R !jq '.'<left> %", { buf = 0 })
