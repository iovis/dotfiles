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
          cursorline = false,
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
      },
      on_open = function(win)
        require("barbecue.ui").toggle(false)

        -- There's a bug if cmdheight = 0 that zen-mode can't hide the statusline
        -- https://github.com/folke/zen-mode.nvim/issues/69
        -- require("lualine").hide({})
        -- vim.o.statusline = " "
      end,
      on_close = function()
        require("barbecue.ui").toggle(true)
        -- require("lualine").hide({ unhide = true })
      end,
    })
  end,
}
