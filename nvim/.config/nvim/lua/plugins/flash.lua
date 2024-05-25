return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    local flash = require("flash")
    flash.setup({
      modes = {
        char = { enabled = false },
      },
    })

    vim.keymap.set({ "n", "x", "o" }, "f", flash.jump, { desc = "Flash" })
    vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
    vim.keymap.set({ "n", "x", "o" }, "F", function()
      flash.jump({ pattern = vim.fn.expand("<cword>") })
    end, { desc = "Flash Word" })
  end,
}
