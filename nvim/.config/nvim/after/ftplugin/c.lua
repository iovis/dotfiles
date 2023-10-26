vim.keymap.set("i", "<m-cr>", "<c-o>A;", { buffer = true })

---- runnables
if vim.fn.expand("%"):match("ext/") then
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake compile<cr>", { buffer = true })
else
  vim.keymap.set("n", "m<cr>", "<cmd>Tux make<cr>", { buffer = true })
end

-- " nnoremap <buffer> s<cr> :Tux make && ./%:r<cr>
-- " nnoremap <buffer> d<cr> :Tux make && lldb ./%:r<cr>
-- nnoremap <buffer> s<cr> :Tux cc -Wall -g % -o %:r && ./%:r<cr>
-- nnoremap <buffer> d<cr> :Tux cc -Wall -g % -o %:r && lldb ./%:r<cr>
