return {
  -- Not lazy because it calculates filetypes
  "NoahTheDuke/vim-just",

  { "chrisbra/csv.vim", ft = "csv" },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "iovis/substitute.vim", event = "VeryLazy" },
  { "tpope/vim-dadbod", cmd = { "DB" }, keys = { { "d<space>", ":DB<space>" } } },
  { "tpope/vim-eunuch", event = "VeryLazy" }, -- UNIX commands
  { "vim-test/vim-test", event = "VeryLazy" },
}
