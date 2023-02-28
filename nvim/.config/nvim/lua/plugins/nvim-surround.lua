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
      surrounds = {
        ["d"] = {
          add = { "dbg!(", ")" },
          find = "dbg!%b()",
          delete = "^(dbg!%()().-(%))()$",
        },
        ["p"] = {
          add = { "pp(", ")" },
          find = "pp%b()",
          delete = "^(pp%()().-(%))()$",
        },
      },
    })

    vim.keymap.set("n", [[<leader>"]], [[cs'"]], { remap = true })
    vim.keymap.set("n", [[<leader>']], [[cs"']], { remap = true })

    -- local hi = require("config.highlights").hi
    -- hi.NvimSurroundHighlightTextObject = "HighlightedYankRegion"
  end,
}
