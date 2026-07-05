local u = require("config.utils")

-- TODO: why does this fail?
-- vim.opt_local.indentkeys:remove({ ".", "0{" })

vim.cmd.compiler("ruby")

vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %:.<cr>", { buf = 0 })

---- Runnables
if u.current_file():match("exe/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle exec %:.<cr>", { buf = 0 })
elseif u.current_file():match("_spec.rb") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux rspec %:.<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buf = 0, silent = true })
  vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buf = 0, silent = true })
elseif u.current_file() == "Gemfile" then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle install<cr>", { buf = 0 })

  if vim.g.custom_hooks then
    -- Only clean up autocmds belonging to this buffer
    local augroup = vim.api.nvim_create_augroup("bundler_dependencies", { clear = false })
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      desc = "Check bundler dependencies",
      group = augroup,
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        require("config.hooks.dependencies").run("bundler")
      end,
    })
  end
end
