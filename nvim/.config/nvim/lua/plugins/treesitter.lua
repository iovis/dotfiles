local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "rrethy/nvim-treesitter-endwise",
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "comment", -- TODO: apparently really slow
      "css",
      "diff", -- git diffs
      "dockerfile",
      "fish",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
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
      "php",
      "python",
      "query", -- treesitter query language
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
      disable = function(lang, buf)
        local max_filesize = 10 * 1024 * 1024 -- 10 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true, -- Experimental
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

  vim.keymap.set("n", "+H", "<cmd>TSHighlightCapturesUnderCursor<cr>")
end

return M
