local M = {
  "kylechui/nvim-surround",
  event = "VeryLazy",
}

function M.config()
  local ok, surround = pcall(require, "nvim-surround")
  if not ok then
    print("nvim-surround not found!")
    return
  end

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

  local u = require("user.utils")
  u.highlight("NvimSurroundHighlightTextObject", { bg = "#8fafd7", fg = "#262626" })
end

return M
