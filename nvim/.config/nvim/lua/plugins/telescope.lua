return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")

    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<c-u>"] = false,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-n>"] = actions.results_scrolling_down,
            ["<c-p>"] = actions.results_scrolling_up,
            ["<esc>"] = actions.close,
            ["<c-h>"] = actions.which_key,
            ["<m-p>"] = action_layout.toggle_preview,
            ["<c-s>"] = actions.cycle_previewers_next,
            -- ["<c-a>"] = actions.cycle_previewers_prev,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--hidden",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
          "-g",
          "!Session.vim",
          "-g",
          "!.git",
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--follow",
            "--exclude",
            ".git",
            "--exclude",
            ".keep",
            "--exclude",
            "Session.vim",
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    vim.keymap.set("n", "+s", ":Telescope<space>")

    local t = require("telescope.builtin")
    -- vim.keymap.set("n", "+m", t.marks, { desc = "t.marks" })
    -- vim.keymap.set("n", "+r", t.registers, { desc = "t.registers" })
    vim.keymap.set("n", "+f", t.live_grep, { desc = "t.live_grep" })
    vim.keymap.set("n", "<c-p>", t.commands, { desc = "t.commands" })
    vim.keymap.set("n", "<leader><leader>", t.buffers, { desc = "t.buffers" })
    vim.keymap.set("n", "<leader>A", t.filetypes, { desc = "t.filetypes" })
    vim.keymap.set("n", "<leader>gH", t.git_bcommits, { desc = "t.git_bcommits" })
    vim.keymap.set("n", "<leader>gL", t.git_commits, { desc = "t.git_commits" })
    vim.keymap.set("n", "<leader>gco", t.git_branches, { desc = "t.git_branches" })
    vim.keymap.set("n", "<leader>j", t.git_status, { desc = "t.git_status" })
    vim.keymap.set("n", "<leader>o", t.find_files, { desc = "t.find_files" })
    vim.keymap.set("n", "<leader>ñ", t.current_buffer_fuzzy_find, { desc = "t.current_buffer_fuzzy_find" })

    vim.keymap.set("n", "<leader>f", function()
      t.grep_string({ search = "\\w", use_regex = true, sort_only_text = true })
    end, { desc = "t.grep" })

    vim.keymap.set("n", "<leader>O", function()
      t.find_files({ hidden = true, no_ignore = true })
    end, { desc = "t.files" })
  end,
}
