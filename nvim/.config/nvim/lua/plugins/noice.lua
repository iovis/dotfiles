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
    local noice = require("noice")

    noice.setup({
      cmdline = {
        enabled = false, -- Needs to be disabled with `messages` as well
      },
      lsp = {
        -- Controlled by lspsaga
        hover = { enabled = false },
        signature = { enabled = false },
      },
      messages = {
        enabled = false, -- enables `cmdline` automatically
        view = "mini",
        view_search = false, -- "virtualtext", show search messages
      },
      popupmenu = {
        -- enabled = false,
        backend = "cmp",
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          -- Filter "No code actions available" messages
          filter = {
            event = "notify",
            kind = "info",
            find = "No code actions available",
          },
          opts = { skip = true },
        },
        {
          -- Filter Lspsaga bug messages
          filter = {
            event = "notify",
            kind = "error",
            find = "method textDocument/codeAction is not supported by any of the servers registered for the current buffer",
          },
          opts = { skip = true },
        },
        {
          -- Filter "buffer written" messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      views = {
        mini = {
          win_options = {
            winblend = 50,
          },
        },
        popup = {
          size = {
            width = "75%",
          },
        },
      },
    })

    vim.keymap.set("n", "+n", function()
      if vim.o.cmdheight == 0 then
        noice.disable()
        vim.o.cmdheight = 1
      else
        noice.enable()
      end
    end, {
      desc = "Toggle Noice",
    })

    vim.keymap.set("c", "<m-cr>", function()
      noice.redirect(vim.fn.getcmdline())
    end, {
      desc = "Redirect Cmdline",
    })

    vim.keymap.set("n", "<leader>M", function()
      noice.cmd("history")
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
