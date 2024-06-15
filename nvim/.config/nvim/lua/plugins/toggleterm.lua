return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-_>]],
      float_opts = { border = "rounded" },
      on_open = function(term)
        vim.defer_fn(function()
          vim.wo[term.window].winbar = nil
        end, 0)
      end,
    })
  end,
}
