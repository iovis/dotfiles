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
    { "<leader>gd", ":DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gh", ":DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gh", ":DiffviewFileHistory<cr>", mode = "x" },
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
        },
        file_history_panel = {
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
        },
      },
    })
  end,
}
