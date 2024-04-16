return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      on_open = function(term)
        vim.defer_fn(function()
          vim.wo[term.window].winbar = ""
        end, 0)
      end,
    })
  end,
}
