return {
  "folke/which-key.nvim",
  enabled = false,
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
    })

    vim.keymap.set("n", "<leader>?", function()
      wk.show({ global = false })
    end, { desc = "Buffer local keymaps" })
  end,
}
