local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {
  disable_netrw = false,
  filters = {
    custom = {
      '*.pyc',
      '.DS_Store',
      '.bundle',
      '.git',
      '.github',
      '.vscode',
      '.yardoc',
      'BqfPreviewBorder',
      'Session.vim',
      'node_modules',
      'tags'
    }
  },
  view = {
    -- These don't seem to work yet
    -- winopts = {
    --   relativenumber = true,
    --   signcolumn = 'no',
    -- },
    mappings = {
      list = {
        { key = "x", cb = tree_cb("close_node") },
        { key = "C", cb = tree_cb("cd") },
        { key = "D", cb = tree_cb("cut") },
        { key = "J", cb = tree_cb("next_sibling") },
        { key = "K", cb = tree_cb("prev_sibling") },
      }
    }
  }
}

vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_width = 35

local nvim_tree_view = require('nvim-tree.view').View
nvim_tree_view.winopts.relativenumber = true
nvim_tree_view.winopts.signcolumn = 'no'

vim.cmd[[highlight NvimTreeRootFolder ctermfg=4 guifg=#7cafc2]]

local u = require('utils')
u.nmap('<leader>k', ':NvimTreeToggle<cr>')
u.nmap('-', ':NvimTreeFindFile<cr>')
