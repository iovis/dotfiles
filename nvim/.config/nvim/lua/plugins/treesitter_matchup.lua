return {
  "andymass/vim-matchup",
  init = function()
    vim.g.matchup_mappings_enabled = 0
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_treesitter_disable_virtual_text = true

    vim.keymap.set({ "n", "x", "o" }, "%", "<plug>(matchup-%)")
  end,
}
