" NOTE: to get all `obcommand`
" 1. cmd+alt+i => open developer console
" 2. Run `:obcommand`
" 3. All commands should now be in the console
imap kj <Esc>

noremap j gj
noremap k gk
noremap H ^
noremap L $
noremap ñ /
noremap Ñ ?

unmap <Space>
exmap workspace_split_horizontal obcommand workspace:split-horizontal
nmap <Space>h :workspace_split_horizontal
exmap workspace_split_vertical obcommand workspace:split-vertical
nmap <Space>v :workspace_split_vertical
exmap workspace_close obcommand workspace:close
nmap <Space>c :workspace_close
exmap editor_save_file obcommand editor:save-file
nmap <Space>w :editor_save_file

exmap app_toggle_sidebar obcommand app:toggle-left-sidebar
nmap <Space>k :app_toggle_sidebar
exmap switcher_open obcommand switcher:open
nmap <Space>o :switcher_open

exmap editor_focus_bottom obcommand editor:focus-bottom
nmap <C-j> :editor_focus_bottom
exmap editor_focus_left obcommand editor:focus-left
nmap <C-h> :editor_focus_left
exmap editor_focus_right obcommand editor:focus-right
nmap <C-l> :editor_focus_right
exmap editor_focus_top obcommand editor:focus-top
nmap <C-k> :editor_focus_top

noremap <Space>ñ :nohl

exmap editor_swap_line_down obcommand editor:swap-line-down
nmap ¶ :editor_swap_line_down
exmap editor_swap_line_up obcommand editor:swap-line-up
nmap § :editor_swap_line_up

" Folds
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold
nmap zc :togglefold
nmap za :togglefold

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall
exmap foldall obcommand editor:fold-all
nmap zM :foldall

" Jumps
exmap back obcommand app:go-back
nmap <c-o> :back
exmap forward obcommand app:go-forward
nmap <c-p> :forward
