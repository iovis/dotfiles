return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = { "tpope/vim-rhubarb" },
  config = function()
    local u = require("config.utils")
    u.ex.abbrev("g", "Git")

    vim.keymap.set("n", "<leader>G", "<cmd>Gtabedit:<cr>)", { remap = true })
    vim.keymap.set("n", "<leader>go", "<cmd>Gread<cr>")
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>gg", ":GBrowse<cr>", { silent = true })

    vim.keymap.set("n", "<leader>lg", "<cmd>Glg -500<cr>")
    u.ex.abbrev("glg", "Glg")
    vim.api.nvim_create_user_command("Glg", [[Git log --graph --pretty='%h -%d %s (%cr) <%an>' <args>]], {
      nargs = "*",
    })

    vim.keymap.set("x", "<leader>lg", ":GitLogLines<cr>", { silent = true })
    vim.api.nvim_create_user_command("GitLogLines", [[Git log -L <line1>,<line2>:% <args>]], {
      range = true,
      nargs = "*",
    })

    -- NOTE: Fugitive expects netrw to exist, or to define your own `:Browse`
    vim.api.nvim_create_user_command("Browse", function(opts)
      vim.ui.open(opts.args)
    end, { force = true, nargs = 1 })
  end,
}
