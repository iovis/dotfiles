return {
  "iovis/muxi.nvim",
  dev = true,
  event = "VeryLazy",
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
        local muxi_path = require("muxi").config.path
        vim.cmd.split(muxi_path)
      end,
      desc = "Open muxi file",
    },
    {
      "<leader>gr",
      function()
        package.loaded["muxi"] = nil
        print("muxi reloaded")
      end,
      desc = "Reload muxi",
    },
  },
  config = function()
    require("muxi").setup({})
  end,
}
