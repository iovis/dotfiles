return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "tpope/vim-rhubarb",
    "iovis/muxi.nvim", -- to not conflict with mappings defined here
  },
  config = function()
    vim.keymap.set("n", "<leader>-", "<cmd>Gedit:<cr>")
    vim.keymap.set("n", "<leader>go", "<cmd>Gread<cr>")
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
    vim.keymap.set("n", "<leader>gl", "<cmd>Glol -500<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>gg", ":GBrowse<cr>", { silent = true })

    vim.cmd([[
    " Git commands {{{ "
    command! -nargs=*        Glol Git log --graph --pretty='%h -%d %s (%cr) <%an>' <args>
    command! -range -nargs=* GLogL Git log -L <line1>,<line2>:% <args>

    command! -nargs=0 Gcm   !git checkout master
    command! -nargs=0 Gcq   !git checkout qa
    command! -nargs=0 Gpsup !git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    command! -nargs=0 Grhh  !git reset --hard
    command! -nargs=1 Gcb   !git checkout -b <args>
    " }}} Git "
    ]])
  end,
}
