return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
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
      "hyprlang",
      "javascript",
      "jsdoc",
      "json",
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
      "tmux",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "zig",
    })

    local augroup = vim.api.nvim_create_augroup("treesitter.config", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "treesitter.config",
      group = augroup,
      callback = function(e)
        if not pcall(vim.treesitter.start, e.buf) then
          return
        end

        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
      end,
    })
  end,
}
