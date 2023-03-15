-- Fallback for treesj for Ruby modules
return {
  "AndrewRadev/splitjoin.vim",
  lazy = false,
  init = function()
    vim.g.splitjoin_join_mapping = "+J"
    vim.g.splitjoin_split_mapping = "+S"
  end,
}
