return {
  -- Not lazy because it calculates filetypes
  "NoahTheDuke/vim-just",
  "jparise/vim-graphql",

  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "iovis/substitute.vim", event = "VeryLazy" },
  { "vim-test/vim-test", event = "VeryLazy" },

  -- Tim Pope zone
  { "tpope/vim-abolish", event = "VeryLazy" }, -- Case coercion: `crs` coerce to snake_case
  { "tpope/vim-eunuch", event = "VeryLazy" }, -- UNIX commands
  { "tpope/vim-repeat", event = "VeryLazy" },
}
