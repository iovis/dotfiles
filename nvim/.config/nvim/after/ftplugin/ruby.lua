vim.cmd.compiler("ruby")

---- runnables
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

---- keymaps
vim.keymap.set("n", "m<cr>", ":!ctags<cr>", { buffer = true, silent = true })

---- quick testing
vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true, silent = true })

---- Solargraph
-- Reset with: bundle exec solargraph clear && bundle exec yard gems --rebuild
vim.keymap.set(
  "n",
  "<leader>sy",
  ":TuxBg! ctags && bundle exec solargraph bundle && bundle exec yard gems; pause<cr>",
  { buffer = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>sr",
  ":TuxBg! ctags && bundle exec solargraph clear && bundle exec solargraph download-core && bundle exec solargraph bundle && bundle exec yard gems --rebuild; pause<cr>",
  { buffer = true, silent = true }
)

-- " Load failing tests in a scratch window
-- nmap <silent> <buffer> +R :Redir !cat tmp/rspec-failures.txt<cr>
--       \ :g/\(passed\\|pending\)/d<cr>
--       \ :v/spec/d<cr>
--       \ :%s/\[\d.*<cr>
--       \ :sort u<cr>
--       \ :%norm! Irspec <cr>
-- " }}} quick testing "
--
-- " sorbet {{{ "
-- " nnoremap <silent> <buffer> <leader>sr :Tux bin/tapioca gems && bin/tapioca dsl && bin/tapioca todo && bin/tapioca check-shims && bundle exec spoom bump<cr>
-- " nnoremap <silent> <buffer> <leader>st :e! sorbet/rbi/todo.rbi<cr>
-- " nnoremap <silent> <buffer> m<cr> :Tux bundle exec srb tc<cr>
-- "
-- " nnoremap <buffer> +T :e sorbet/rbi/shims/<c-r>%<cr>
-- " }}} sorbet "
