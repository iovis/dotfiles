return {
  -- Not lazy because it calculates filetypes
  "NoahTheDuke/vim-just",
  "jparise/vim-graphql",
  "tpope/vim-git",
  "tpope/vim-rhubarb",

  -- Other library dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "tpope/vim-dotenv", lazy = true },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "iovis/browsers_castle", event = "VeryLazy" },
  { "iovis/substitute.vim", event = "VeryLazy" },
  { "tpope/vim-abolish", event = "VeryLazy" },
  { "tpope/vim-bundler", event = "VeryLazy" },
  { "tpope/vim-characterize", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-ragtag", event = "VeryLazy" },
  { "tpope/vim-rails", event = "VeryLazy" },
  { "tpope/vim-rake", event = "VeryLazy" },
  { "tpope/vim-rbenv", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-speeddating", event = "VeryLazy" },
  { "vim-test/vim-test", event = "VeryLazy" },
}
