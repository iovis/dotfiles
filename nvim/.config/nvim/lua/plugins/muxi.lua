return {
  "iovis/muxi.nvim",
  dev = true,
  keys = {
    {
      "<leader>gj",
      function()
        require("muxi").test()
      end,
      desc = "Run muxi",
    },
    {
      "<leader>gm",
      function()
        local muxi_path = vim.fn.stdpath("data") .. "/muxi.json"
        vim.cmd.split(muxi_path)
      end,
      desc = "Open muxi file",
    },
  },
  config = function()
    require("muxi")
  end,
}
