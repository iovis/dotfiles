return {
  "tpope/vim-projectionist",
  lazy = false,
  keys = {
    { "<leader>aa", "<cmd>A<cr>" },
    { "<leader>ah", "<cmd>AS<cr>" },
    { "<leader>av", "<cmd>AV<cr>" },
    { "<leader>up", "<cmd>e! .projections.json<cr>" },
  },
}
