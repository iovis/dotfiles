return {
  "folke/noice.nvim",
  -- enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        fps = 60,
        render = "compact",
        stages = "fade",
        -- timeout = 1000,
        -- max_width = 30,
      },
    },
  },
  config = function()
    require("noice").setup({
      cmdline = {
        -- enabled = false,
      },
      lsp = {
        -- Controlled by lspsaga
        hover = { enabled = false },
        signature = { enabled = false },
      },
      messages = {
        -- enabled = false,
        view = "mini",
        view_search = false, -- "virtualtext", show search messages
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          -- Filter "buffer written" messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        { -- Send long "messages" to a split
          filter = {
            -- event = "msg_show",
            min_height = 5,
          },
          view = "split",
        },
      },
      views = {
        mini = {
          win_options = {
            winblend = 50,
          },
        },
      },
    })

    vim.keymap.set("c", "<m-cr>", function()
      require("noice").redirect(vim.fn.getcmdline())
    end, {
      desc = "Redirect Cmdline",
    })

    vim.keymap.set("n", "<leader>M", function()
      require("noice").cmd("history")
    end, {
      desc = "Noice history",
    })

    vim.keymap.set("n", "<leader>ñ", function()
      require("notify").dismiss({})
      vim.cmd.nohlsearch()
    end, {
      desc = "Clean notifications and hlsearch",
    })
  end,
}
