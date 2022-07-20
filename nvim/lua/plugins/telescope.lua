local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

require("telescope").setup({
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
        ["<c-a>"] = actions.cycle_previewers_prev,
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

-- vim.keymap.set("n", "+s", ":Telescope<space>")
--
local t = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", t.commands, { desc = "t.commands" })
-- vim.keymap.set("n", "+f", t.live_grep, { desc = "t.live_grep" })
-- vim.keymap.set("n", "+m", t.marks, { desc = "t.marks" })
vim.keymap.set("n", "+r", t.registers, { desc = "t.registers" })
-- vim.keymap.set("n", "<leader>o", t.find_files, { desc = "t.find_files" })
vim.keymap.set("n", "<leader><leader>", t.buffers, { desc = "t.buffers" })
vim.keymap.set("n", "<leader>A", t.filetypes, { desc = "t.filetypes" })
vim.keymap.set("n", "<leader>H", t.git_bcommits, { desc = "t.git_bcommits" })
-- vim.keymap.set("n", "<leader>gL", t.git_commits, { desc = "t.git_commits" })
-- vim.keymap.set("n", "<leader>gco", t.git_branches, { desc = "t.git_branches" })
-- vim.keymap.set("n", "<leader>j", t.git_status, { desc = "t.git_status" })
-- vim.keymap.set("n", "<leader>r", t.lsp_document_symbols, { desc = "t.lsp_document_symbols" })
-- vim.keymap.set("n", "<leader>R", t.lsp_workspace_symbols, { desc = "t.lsp_workspace_symbols" })
vim.keymap.set("n", "<leader>ñ", t.current_buffer_fuzzy_find, { desc = "t.current_buffer_fuzzy_find" })

-- vim.keymap.set("n", "<leader>f", function()
--   t.grep_string({ search = "\\w", use_regex = true, sort_only_text = true })
-- end, { desc = "t.grep" })
--
-- vim.keymap.set("n", "<leader>O", function()
--   t.find_files({ hidden = true, no_ignore = true })
-- end, { desc = "t.files" })
