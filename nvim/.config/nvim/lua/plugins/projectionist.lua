return {
  "tpope/vim-projectionist",
  lazy = false,
  dependencies = {
    "tpope/vim-dispatch",
    init = function()
      vim.g.dispatch_no_maps = 1
    end,
  },
  keys = {
    { "<leader>S", "<cmd>Start!<cr>" },
    { "<leader>aa", "<cmd>A<cr>" },
    { "<leader>ah", "<cmd>AS<cr>" },
    { "<leader>ar", "<cmd>R<cr>" },
    { "<leader>av", "<cmd>AV<cr>" },
    -- { "m<space>", ":Make<space>" },
  },
}
