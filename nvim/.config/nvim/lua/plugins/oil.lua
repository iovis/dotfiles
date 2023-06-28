return {
  "stevearc/oil.nvim",
  cmd = { "Oil" },
  keys = {
    { "-", "<cmd>Oil --float<cr>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local oil = require("oil")

    oil.setup({
      default_file_explorer = false,
      float = {
        max_height = 20,
        max_width = 75,
        win_options = {
          winblend = 0,
        },
      },
      keymaps = {
        ["R"] = "actions.refresh",
        ["q"] = {
          desc = "Save and close",
          callback = function()
            oil.save()
            oil.close()
          end,
          nowait = true,
        },
      },
      view_options = {
        show_hidden = true,
      },
    })

    local oil_augroup = vim.api.nvim_create_augroup("oil_augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Accept changes with <CR>",
      group = oil_augroup,
      pattern = "oil_preview",
      callback = function(params)
        vim.keymap.set("n", "<cr>", "o", {
          buffer = params.buf,
          remap = true,
          nowait = true,
        })
      end,
    })
  end,
}
