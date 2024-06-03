return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>" },
  },
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 1,
        height = 0.9,
        width = 0.9,
        options = {
          -- vim.wo options
          cursorcolumn = false,
          cursorline = true,
          foldcolumn = "0",
          list = false,
          number = false,
          relativenumber = false,
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          enabled = true,
          laststatus = 0,
        },
        -- tmux = { enabled = true },
        twilight = { enabled = false },
      },
    })
  end,
}
