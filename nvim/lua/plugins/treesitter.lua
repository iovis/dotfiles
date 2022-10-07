require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "css",
    "dockerfile",
    "graphql",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "make",
    "php",
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
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
      -- scope_incremental = "<c-s>",
      node_decremental = "<c-p>",
    },
  },
  indent = {
    enable = false, -- Experimental
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
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
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

require("treesitter-context").setup({
  patterns = {
    ruby = {
      "do_block",
      "module",
    },
  },
})

vim.keymap.set("n", "+h", "<cmd>TSHighlightCapturesUnderCursor<cr>")
