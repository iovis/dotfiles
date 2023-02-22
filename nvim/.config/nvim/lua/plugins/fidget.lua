return {
  "j-hui/fidget.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("fidget").setup({
      text = {
        spinner = "dots",
      },
      window = {
        relative = "editor",
        blend = 0,
      },
      sources = {
        ["null-ls"] = {
          ignore = true,
        },
      },
    })
  end,
}
