return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    local flash = require("flash")

    flash.setup({
      prompt = { enabled = false },
      search = {
        multi_window = false,
      },
    })

    vim.keymap.set({ "n", "x", "o" }, "f", flash.jump, { desc = "Flash" })
    vim.keymap.set({ "n", "x", "o" }, "F", flash.treesitter, { desc = "Flash" })
  end,
}
