vim.cmd.compiler("ruby")

vim.keymap.set("n", "m<cr>", ":!ctags<cr>", { buffer = true })
vim.keymap.set("n", "<leader>b", vim.lsp.buf.format, { buffer = true })

---- Solargraph
-- Reset with: bundle exec solargraph clear && bundle exec yard gems --rebuild
vim.keymap.set(
  "n",
  "<leader>sy",
  ":TuxBg! ctags && bundle exec solargraph bundle && bundle exec yard gems<cr>",
  { buffer = true }
)

vim.keymap.set(
  "n",
  "<leader>sr",
  ":TuxBg! ctags && bundle exec solargraph clear && bundle exec solargraph download-core && bundle exec solargraph bundle && bundle exec yard gems --rebuild<cr>",
  { buffer = true }
)

---- quick testing
vim.keymap.set("n", "<leader>sd", ":TestFile --format documentation<cr>", { buffer = true })
vim.keymap.set("n", "<leader>sp", ":TestNearest -strategy=test_prof<cr>", { buffer = true })

---- runnables
if string.match(vim.fn.expand("%"), "_spec.rb") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux rspec %<cr>", { buffer = true })
elseif string.match(vim.fn.expand("%"), "bin/console") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bin/console<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux ruby %<cr>", { buffer = true })
end

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
