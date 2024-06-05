return {
  "nvimtools/none-ls.nvim",
  -- enabled = false,
  config = function()
    local null_ls = require("null-ls")
    local d = null_ls.builtins.diagnostics

    null_ls.setup({
      debug = false,
      sources = {
        d.erb_lint,
        d.fish,
        -- d.yamllint,
      },
    })
  end,
}
