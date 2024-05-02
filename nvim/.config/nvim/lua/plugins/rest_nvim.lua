local enabled = false

return {
  {
    "vhyrro/luarocks.nvim",
    enabled = enabled,
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    enabled = enabled,
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup({
        highlight = { timeout = 100 },
        result = {
          keybinds = {
            prev = "<",
            next = ">",
          },
        },
      })
    end,
  },
}
