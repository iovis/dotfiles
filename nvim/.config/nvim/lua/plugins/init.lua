vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

return {
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "tpope/vim-dadbod", cmd = { "DB" }, keys = { { "d<space>", ":DB<space>" } } },
  { "vim-test/vim-test", event = "VeryLazy" },
}
