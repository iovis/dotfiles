return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "rrethy/nvim-treesitter-endwise",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "cmake",
        "comment",
        "css",
        "diff", -- git diffs
        "dockerfile",
        "elixir",
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
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
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
        "swift",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
      },
      endwise = {
        enable = true,
      },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 10 * 1024 * 1024 -- 10 MB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
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

    require("treesitter-context").setup({})

    vim.keymap.set("n", "+H", "<cmd>TSHighlightCapturesUnderCursor<cr>")
    vim.keymap.set("n", "yox", "<cmd>TSContextToggle<cr>")
  end,
}
