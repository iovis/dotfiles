return {
  "iovis/browsers_castle",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "go<space>", ":Google<space>")
    vim.keymap.set("n", "go<cr>", ":Google <c-r><c-w><cr>")

    vim.keymap.set("x", "go<space>", 'y:Google <c-r>"')
    vim.keymap.set("x", "go<cr>", 'y:Google <c-r>"<cr>')

    -- NOTE: Fugitive expects netrw to exist, otherwise to define your own `:Browse`
    --       Right now I'm using `oil.nvim` as a netrw replacement
    vim.api.nvim_create_user_command("Browse", function(opts)
      vim.cmd.Browser(vim.fn.escape(opts.args, "%#!"))
    end, { nargs = 1 })
  end,
}
