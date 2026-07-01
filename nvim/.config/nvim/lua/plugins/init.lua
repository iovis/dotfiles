vim.cmd("packadd! cfilter")
vim.cmd("packadd! nvim.difftool")
vim.cmd("packadd! nvim.undotree")
vim.cmd("packadd! termdebug")

return {
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "vim-test/vim-test", event = "VeryLazy" },
}
