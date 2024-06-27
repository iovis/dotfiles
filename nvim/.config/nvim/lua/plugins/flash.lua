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
  end,
}
