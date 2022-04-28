local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<c-u>"] = false,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<c-p>"] = actions.results_scrolling_down,
        ["<c-n>"] = actions.results_scrolling_up,
        ["<c-h>"] = "which_key",
      },
    },
  },
})

require("telescope").load_extension("fzf")
-- require("telescope").load_extension("gh")

vim.keymap.set("n", "+s", ":Telescope<space>")

local t = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", t.commands)
vim.keymap.set("n", "+f", t.live_grep)
vim.keymap.set("n", "+m", t.marks)
vim.keymap.set("n", "+r", t.registers)
vim.keymap.set("n", "<leader>o", t.find_files)
vim.keymap.set("n", "<leader><leader>", t.buffers)
vim.keymap.set("n", "<leader>A", t.filetypes)
vim.keymap.set("n", "<leader>H", t.git_bcommits)
vim.keymap.set("n", "<leader>gL", t.git_commits)
vim.keymap.set("n", "<leader>gco", t.git_branches)
vim.keymap.set("n", "<leader>j", t.git_status)
vim.keymap.set("n", "<leader>r", t.lsp_document_symbols)
vim.keymap.set("n", "<leader>R", t.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>ñ", t.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>f", function()
  t.grep_string({ search = "\\w", use_regex = true, sort_only_text = true })
end)

vim.keymap.set("n", "<leader>O", function()
  t.find_files({ hidden = true, no_ignore = true })
end)
