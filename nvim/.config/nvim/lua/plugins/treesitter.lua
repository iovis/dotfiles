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
    })

    vim.api.nvim_create_autocmd("FileType", {
      desc = "User: enable treesitter highlighting",
      callback = function()
        if not pcall(vim.treesitter.start) then
          return
        end

        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end,
    })
  end,
}
