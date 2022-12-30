return {
  { "andrewradev/splitjoin.vim", event = "VeryLazy" },
  { "chrisbra/csv.vim", event = "VeryLazy" },
  { "christoomey/vim-sort-motion", event = "VeryLazy" },
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
  { "iovis/browsers_castle", event = "VeryLazy" },
  { "iovis/hubcap.vim", event = "VeryLazy" },
  { "iovis/jirafa.vim", event = "VeryLazy" },
  { "iovis/resize.vim", event = "VeryLazy" },
  { "iovis/substitute.vim", event = "VeryLazy" },
  { "iovis/tux.vim", event = "VeryLazy" },
  { "iovis/vimlook", event = "VeryLazy" },
  { "jparise/vim-graphql", event = "VeryLazy" },
  { "mbbill/undotree", event = "VeryLazy" },
  { "moll/vim-bbye", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "rrethy/nvim-base16", lazy = true, priority = 1000 },
  { "schickling/vim-bufonly", event = "VeryLazy" },
  { "tommcdo/vim-lion", event = "VeryLazy" },
  { "tpope/vim-abolish", event = "VeryLazy" },
  { "tpope/vim-bundler", event = "VeryLazy" },
  { "tpope/vim-characterize", event = "VeryLazy" },
  { "tpope/vim-dadbod", event = "VeryLazy" },
  { "tpope/vim-dispatch", event = "VeryLazy" },
  { "tpope/vim-dotenv", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-git", event = "VeryLazy" },
  { "tpope/vim-projectionist", event = "VeryLazy" },
  { "tpope/vim-ragtag", event = "VeryLazy" },
  { "tpope/vim-rails", event = "VeryLazy" },
  { "tpope/vim-rake", event = "VeryLazy" },
  { "tpope/vim-rbenv", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-rhubarb", event = "VeryLazy" },
  { "tpope/vim-scriptease", event = "VeryLazy" },
  { "tpope/vim-speeddating", event = "VeryLazy" },
  { "vim-test/vim-test", event = "VeryLazy" },
  { "wellle/targets.vim", event = "VeryLazy" },

  {
    "kana/vim-textobj-user",
    event = "VeryLazy",
    dependencies = {
      "kana/vim-textobj-entire",
      "kana/vim-textobj-indent",
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
}
