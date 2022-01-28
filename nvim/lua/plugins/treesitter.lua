require("nvim-treesitter.configs").setup({
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-n>",
      node_incremental = "<c-n>",
      scope_incremental = "<c-s>",
      node_decremental = "<c-p>",
    },
  },
  indent = {
    enable = true,
    disable = {
      "python",
      "ruby",
    },
  },
  playground = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
})

local u = require("utils")
u.nmap("+h", ":TSHighlightCapturesUnderCursor<cr>")
-- u.nmap('+t', ':TSPlaygroundToggle<cr>')
