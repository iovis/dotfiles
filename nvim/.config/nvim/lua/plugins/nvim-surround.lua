return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    local surround = require("nvim-surround")

    -- local config = require("nvim-surround.config")

    surround.setup({
      move_cursor = false,
      highlight = {
        duration = 5000,
      },
    })

    vim.keymap.set("n", [[<leader>"]], [[cs'"]], { remap = true })
    vim.keymap.set("n", [[<leader>']], [[cs"']], { remap = true })
  end,
}
