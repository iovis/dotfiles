vim.cmd.compiler("ruby")

vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %:.<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", ":SolargraphRebuild!<cr>", { buffer = true })

---- Runnables
if vim.fn.expand("%"):match("_spec.rb") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux rspec %<cr>", { buffer = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Run RSpec on save",
    group = vim.api.nvim_create_augroup("rspec_runner", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = require("config.hooks.rspec").run,
  })
elseif vim.fn.expand("%"):match("Gemfile") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bundle install<cr>", { buffer = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check bundler dependencies",
    group = vim.api.nvim_create_augroup("bundler_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      require("config.hooks.dependencies").run("bundler")
    end,
  })
end

---- Quick Testing
vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true, silent = true })

---- Solargraph
vim.api.nvim_buf_create_user_command(0, "SolargraphRebuild", function(ctx)
  local cmd = "TuxBg! ctags && bundle exec yard gems"

  if ctx.bang then
    cmd = cmd .. " --rebuild; pause"
  end

  vim.cmd(cmd)
end, { bang = true })

---- Load failing tests in a scratch window
vim.api.nvim_buf_create_user_command(0, "FailedRSpecTests", function()
  vim.cmd("R .")
  vim.cmd("r tmp/rspec-failures.txt")
  vim.cmd([[v/| failed/d]])

  local ok, _ = pcall(vim.cmd, [[%s/\v[\d.*]])
  vim.cmd.nohlsearch()

  if not ok then
    vim.cmd("norm! Ino failed tests!")
    return
  end

  vim.cmd("sort u")
  vim.cmd("%norm! Irspec ")
  vim.cmd("se ft=sh")
end, {})

---- Regenerate Rubocop TODO
vim.api.nvim_buf_create_user_command(0, "RubocopRegenerateTodo", function()
  vim.cmd.Tux("rubocop --regenerate-todo")
end, {})
