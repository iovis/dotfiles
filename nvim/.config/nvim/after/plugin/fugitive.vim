nmap <silent> <leader>- :Gedit:<cr>)

nnoremap <leader>gm :Git mergetool<cr>
nnoremap <leader>go :Gread<cr>

nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <silent> <leader>gg :GBrowse<cr>

nnoremap <silent> <leader>gh :Glol %<cr>
nnoremap <silent> <leader>gl :Glol -500<cr>

xnoremap <silent> <leader>gg :GBrowse<cr>
xnoremap <silent> <leader>gh :GLogL<cr>

nnoremap <silent> <leader>gdv :Gvdiffsplit<cr>
nnoremap <silent> <leader>gdh :Ghdiffsplit<cr>
nnoremap <silent> <leader>gdm :Gdiffsplit master<cr>

nnoremap <leader>gprq :Git hub pull-request --push --browse -m '' --edit -a iovis -b qa -l 'Needs Review'
nnoremap <leader>gprm :Git hub pull-request --push --browse -m '' --edit -a iovis -b master -M 'Next' -l 'Waiting for QA'

command! -nargs=* Glol Git log --graph --pretty='%h -%d %s (%cr) <%an>' <args>
command! -range -nargs=* GLogL Git log -L <line1>,<line2>:% <args>
