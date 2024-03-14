return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = { visual = "s" },
      move_cursor = false,
      highlight = { duration = 5000 },
    })

    vim.keymap.set("n", [[<leader>"]], [[cs'"]], { remap = true })
    vim.keymap.set("n", [[<leader>']], [[cs"']], { remap = true })
  end,
}
