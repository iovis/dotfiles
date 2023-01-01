return {
  "tpope/vim-projectionist",
  dependencies = {
    "tpope/vim-dispatch",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>S", "<cmd>Start!<cr>" },
    { "<leader>aa", "<cmd>A<cr>" },
    { "<leader>ah", "<cmd>AS<cr>" },
    { "<leader>ar", "<cmd>R<cr>" },
    { "<leader>av", "<cmd>AV<cr>" },
  },
}
