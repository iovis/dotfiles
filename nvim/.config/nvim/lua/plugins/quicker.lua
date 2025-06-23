return {
  "stevearc/quicker.nvim",
  version = "*",
  -- enabled = false,
  config = function()
    local quicker = require("quicker")

    quicker.setup({
      borders = { vert = " " },
      constrain_cursor = true,
      highlight = { lsp = false },
      keys = {
        { "<leader>w", "<cmd>write<cr>" },
      },
      opts = {
        number = true,
        relativenumber = true,
      },
      type_icons = {
        E = "",
        W = "",
        I = "",
        N = "",
        H = "",
      },
      max_filename_width = function()
        if vim.g.quicker_expanded then
          return math.huge
        else
          return math.floor(math.min(95, vim.o.columns / 4))
        end
      end,
    })

    -- https://github.com/stevearc/quicker.nvim/issues/54
    local augroup = vim.api.nvim_create_augroup("quicker_bindings", { clear = true })
    vim.g.quicker_expanded = true

    vim.api.nvim_create_autocmd("FileType", {
      desc = "quicker.nvim bindings",
      group = augroup,
      pattern = { "qf" },
      callback = function(event)
        vim.keymap.set("n", "yoe", function()
          -- It creates a new quickfix, but at least it's properly formatted
          vim.g.quicker_expanded = not vim.g.quicker_expanded
          vim.fn.setqflist(vim.fn.getqflist())
        end, {
          desc = "Toggle quicker.nvim filename width",
          buffer = event.buf,
        })
      end,
    })
  end,
}
