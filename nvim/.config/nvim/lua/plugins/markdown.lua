return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      code = {
        width = "block",
        left_pad = 2,
        right_pad = 2,
      },
      heading = {
        width = "block",
        left_pad = 1,
        right_pad = 1,
      },
    })
  end,
}
