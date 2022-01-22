local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
  disable_netrw = false,
  filters = {
    custom = {
      "*.pyc",
      ".DS_Store",
      ".bundle",
      ".git",
      ".github",
      ".vscode",
      ".yardoc",
      "BqfPreviewBorder",
      "Session.vim",
      "node_modules",
      "tags",
    },
  },
  view = {
    -- relativenumber = true,
    -- signcolumn = "no",
    mappings = {
      list = {
        { key = "x", cb = tree_cb("close_node") },
        { key = "C", cb = tree_cb("cd") },
        { key = "D", cb = tree_cb("cut") },
        { key = "J", cb = tree_cb("next_sibling") },
        { key = "K", cb = tree_cb("prev_sibling") },
      },
    },
  },
})

vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_width = 35

vim.cmd([[
  highlight NvimTreeRootFolder ctermfg=4 guifg=#7cafc2
  highlight NvimTreeStatusLine ctermbg=0 guibg=#181818
  highlight NvimTreeEndOfBuffer ctermfg=0 guifg=#181818
  highlight NvimTreeVertSplit ctermfg=18 ctermbg=18 guifg=#282828 guibg=#282828
]])

local u = require("utils")
u.nmap("<leader>k", ":NvimTreeToggle<cr>")
u.nmap("-", ":NvimTreeFindFile<cr>")
