vim.cmd.compiler("ruby")

vim.keymap.set("n", "m<cr>", ":!ctags<cr>", { buffer = true, silent = true })

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
elseif vim.fn.expand("%"):match("bin/console") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bin/console<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %<cr>", { buffer = true })
end

---- Quick Testing
vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true, silent = true })

---- Solargraph
vim.keymap.set("n", "<leader>sr", ":TuxBg! ctags && bundle exec yard gems<cr>", { buffer = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>sR",
  ":TuxBg! ctags && bundle exec yard gems --rebuild; pause<cr>",
  { buffer = true, silent = true }
)

---- Load failing tests in a scratch window
vim.keymap.set("n", "<leader>TR", function()
  vim.cmd("R .")
  vim.cmd("r tmp/rspec-failures.txt")
  vim.cmd([[v/| failed/d]])
  vim.cmd([[%s/\v[\d.*]])
  vim.cmd("sort u")
  vim.cmd("%norm! Irspec ")
  vim.cmd("se ft=sh")
end, { buffer = true, silent = true, desc = "Show RSpec suite failures" })

---- Regenerate Rubocop TODO
vim.api.nvim_buf_create_user_command(0, "RubocopRegenerateTodo", function()
  vim.cmd.Tux("rubocop --regenerate-todo")
end, {})
