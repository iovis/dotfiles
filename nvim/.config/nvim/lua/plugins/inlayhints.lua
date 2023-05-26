return {
  "lvimuser/lsp-inlayhints.nvim",
  enabled = false,
  event = "LspAttach",
  config = function()
    require("lsp-inlayhints").setup({
      inlay_hints = {
        -- parameter_hints = {
        --   show = false,
        -- },
        highlight = "Comment",
      },
    })
  end,
}
