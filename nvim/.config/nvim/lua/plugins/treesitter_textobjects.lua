return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  config = function()
    require("nvim-treesitter-textobjects").setup({})

    local keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    }

    for key, selector in pairs(keymaps) do
      vim.keymap.set({ "x", "o" }, key, function()
        require("nvim-treesitter-textobjects.select").select_textobject(selector, "textobjects")
      end, { desc = ("[nvim-treesitter-textobjects] %s"):format(selector) })
    end

    -- Swap
    vim.keymap.set("n", "g<", function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
    end, { desc = "[nvim-treesitter-textobjects] @parameter.inner backward" })

    vim.keymap.set("n", "g>", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end, { desc = "[nvim-treesitter-textobjects] @parameter.inner forward" })
  end,
}
