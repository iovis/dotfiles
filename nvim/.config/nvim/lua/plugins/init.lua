vim.cmd.packadd("cfilter")

return {
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "tpope/vim-dadbod", cmd = { "DB" }, keys = { { "d<space>", ":DB<space>" } } },
  { "vim-test/vim-test", event = "VeryLazy" },
}
