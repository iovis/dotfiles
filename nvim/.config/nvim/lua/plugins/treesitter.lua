return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "andymass/vim-matchup",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "rrethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    vim.keymap.set("n", "yot", "<cmd>TSContextToggle<cr>")
    vim.g.matchup_matchparen_offscreen = {}

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "css",
        "diff", -- git diffs
        "dockerfile",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "http",
        "hurl",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query", -- treesitter query language
        "regex",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
      },
      autotag = { enable = true },
      endwise = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
      matchup = {
        enable = true,
        disable_virtual_text = true,
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
  end,
}
