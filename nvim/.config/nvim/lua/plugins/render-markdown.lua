return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      anti_conceal = { enabled = false },
      bullet = { enabled = false },
      checkbox = { enabled = false },
      pipe_table = { preset = "round" },
      heading = {
        sign = false,
        backgrounds = {},
        icons = {},
      },
      code = {
        sign = false,
        inline = false,
        width = "block",
        right_pad = 1,
        border = "thick",
      },
    })
  end,
}
