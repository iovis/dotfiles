require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      'python',
      'ruby', -- [workaround] Allow for matchit and vim-endwise to work
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-n>",
      node_incremental = "<c-n>",
      scope_incremental = "<c-s>",
      node_decremental = "<c-p>",
    }
  },
  indent = {
    enable = true,
    disable = {
      "python",
      "ruby",
    },
  },
  playground = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ad"] = "@block.outer",
        ["id"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["g>"] = "@parameter.inner",
      },
      swap_previous = {
        ["g<"] = "@parameter.inner",
      },
    },
  },
}

require('map_helpers')
nnoremap('+h', ':TSHighlightCapturesUnderCursor<cr>')
nnoremap('+t', ':TSPlaygroundToggle<cr>')
