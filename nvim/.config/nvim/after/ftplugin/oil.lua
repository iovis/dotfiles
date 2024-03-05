-- oil.get_current_dir()
-- NOTE: Disable when using `--float`
vim.wo.winbar = "%#barbecue_separator#        %{%v:lua.require'oil'.get_current_dir()%}"
