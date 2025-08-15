return {
  "andymass/vim-matchup",
  init = function()
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_treesitter_disable_virtual_text = true
  end,
}
