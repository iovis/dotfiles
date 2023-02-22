return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        fps = 60,
        -- max_width = 30,
        -- timeout = 10,
      },
    },
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- Controlled by lspsaga
        hover = { enabled = false },
        signature = { enabled = false },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    })

    vim.keymap.set("c", "<m-cr>", function()
      require("noice").redirect(vim.fn.getcmdline())
    end, {
      desc = "Redirect Cmdline",
    })

    vim.keymap.set("n", "<leader>ñ", function()
      require("notify").dismiss({})
      vim.cmd.nohlsearch()
    end, {
      desc = "Clean notifications and hlsearch",
    })
  end,
}
