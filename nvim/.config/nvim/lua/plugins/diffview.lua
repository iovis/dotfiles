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
    { "<leader>dv", ":DiffviewOpen<cr>", silent = true },
    { "<leader>df", ":DiffviewFileHistory %<cr>", silent = true },
    { "<leader>D", ":DiffviewFileHistory<cr>", silent = true, mode = "x" },
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
        },
        file_panel = {
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
        },
        file_history_panel = {
          ["<tab>"] = false,
          ["<s-tab>"] = false,
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
        },
      },
    })
  end,
}
