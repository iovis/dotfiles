return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "DiffviewFileHistory",
    "DiffviewOpen",
  },
  keys = {
    { "<leader>gd", ":DiffviewOpen<cr>", silent = true },
    { "<leader>gh", ":DiffviewFileHistory %<cr>", silent = true },
    { "<leader>gh", ":DiffviewFileHistory<cr>", silent = true, mode = "x" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      keymaps = {
        view = {
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
        },
        file_panel = {
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
        },
        file_history_panel = {
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
        },
      },
    })
  end,
}
