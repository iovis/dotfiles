return {
  -- Not lazy because it calculates filetypes
  "NoahTheDuke/vim-just",
  "jparise/vim-graphql",

  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "iovis/browsers_castle", event = "VeryLazy" },
  { "iovis/substitute.vim", event = "VeryLazy" },
  { "vim-test/vim-test", event = "VeryLazy" },

  -- Tim Pope zone
  { "tpope/vim-abolish", event = "VeryLazy" }, -- Case coercion: `crs` coerce to snake_case
  { "tpope/vim-dotenv", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" }, -- UNIX commands
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "tpope/vim-rails",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-bundler",
      "tpope/vim-projectionist",
      "tpope/vim-rake",
    },
  },
}
