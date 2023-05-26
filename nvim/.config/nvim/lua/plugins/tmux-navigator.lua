return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" }, -- c-ç
  },
  init = function()
    vim.g.tmux_navigator_save_on_switch = 2

    -- Otherwise they'll map in select mode and mess up snippets
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
