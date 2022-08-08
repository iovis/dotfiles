local config = require("nvim-surround.config")

require("nvim-surround").setup({
  move_cursor = false,
  highlight = {
    duration = 5000,
  },
  surrounds = {
    ["*"] = {
      add = { "*", "*" },
      find = function()
        return config.get_selection({ textobject = "*" })
      end,
      delete = "^(. ?)().-( ?.)()$",
      change = {
        target = "^(. ?)().-( ?.)()$",
      },
    },
    ["_"] = {
      add = { "_", "_" },
      find = function()
        return config.get_selection({ textobject = "_" })
      end,
      delete = "^(. ?)().-( ?.)()$",
      change = {
        target = "^(. ?)().-( ?.)()$",
      },
    },
    ["/"] = {
      add = { "/", "/" },
      find = function()
        return config.get_selection({ textobject = "/" })
      end,
      delete = "^(. ?)().-( ?.)()$",
      change = {
        target = "^(. ?)().-( ?.)()$",
      },
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

local u = require("utils")
u.highlight("NvimSurroundHighlightTextObject", { bg = "#8fafd7", fg = "#262626" })
