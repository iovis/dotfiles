vim.keymap.set("n", "S", function()
  -- `just --choose --chooser fzf-tmux`?
  --
  -- Maybe do a vim.ui.select with `just --list` and run the chosen command through Tux?
  vim.notify("You should really do something with this key")
end)
