-- https://neovim.getkulala.net/docs/usage

return {
  "mistweaverco/kulala.nvim",
  version = "*",
  ft = "http",
  config = function()
    local kulala = require("kulala")

    kulala.setup({
      default_view = "headers_body",
      icons = {
        inlay = {
          done = "✔",
          error = "✗",
          loading = "■",
        },
      },
      kulala_keymaps = {
        -- ~/.local/share/nvim/lazy/kulala.nvim/lua/kulala/config/keymaps.lua
        ["Previous response"] = {
          "<",
          function()
            require("kulala.ui").show_previous()
          end,
        },
        ["Next response"] = {
          ">",
          function()
            require("kulala.ui").show_next()
          end,
        },
      },
    })
  end,
}
