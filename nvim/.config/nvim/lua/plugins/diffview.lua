return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local actions = require("diffview.actions")

    local function toggle_diffview(cmd)
      if next(require("diffview.lib").views) == nil then
        vim.cmd(cmd)
      else
        vim.cmd("DiffviewClose")
      end
    end

    vim.keymap.set("n", "<leader>di", function()
      toggle_diffview("DiffviewOpen")
    end, { desc = "Diffview open" })

    vim.keymap.set("n", "<leader>dm", function()
      toggle_diffview("DiffviewOpen master..HEAD")
    end, { desc = "Diffview current with master" })

    vim.keymap.set("n", "<leader>dh", function()
      toggle_diffview("DiffviewFileHistory %")
    end, { desc = "Diffview current file history" })

    vim.keymap.set("x", "<leader>dh", ":DiffviewFileHistory<cr>", {
      silent = true,
      desc = "Diffview current file history",
    })

    vim.keymap.set("n", "<leader>dl", function()
      toggle_diffview("DiffviewFileHistory")
    end, { desc = "Diffview all commits" })

    require("diffview").setup({
      keymaps = {
        view = {
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          { "n", "<leader>k", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "r", actions.cycle_layout, { desc = "Cycle available layouts" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
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
