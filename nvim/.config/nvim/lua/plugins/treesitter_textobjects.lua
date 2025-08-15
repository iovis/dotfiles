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
      ["aj"] = "@block.outer",
      ["ij"] = "@block.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",

      -- custom
      -- markdown list items
      ["au"] = "@list_item.outer",
      ["iu"] = "@list_item.inner",
    }

    for key, selector in pairs(keymaps) do
      vim.keymap.set({ "x", "o" }, key, function()
        require("nvim-treesitter-textobjects.select").select_textobject(selector, "textobjects")
      end)
    end

    -- Swap
    vim.keymap.set("n", "g<", function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
    end)

    vim.keymap.set("n", "g>", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end)
  end,
}
