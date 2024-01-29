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
    { "<leader>df", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview current file history" },
    { "<leader>dc", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview all commits" },
    { "<leader>dh", ":DiffviewFileHistory<cr>", silent = true, mode = "x" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      keymaps = {
        view = {
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
    })
  end,
}
