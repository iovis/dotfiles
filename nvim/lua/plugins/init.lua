-- Ensure packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

-- Compile plugins when file is changed
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  pattern = "init.lua",
  group = group,
})

vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<cr>")

-- plugins
require("packer").init({
  max_jobs = 50,
})
require("packer").startup({
  function()
    use("andrewradev/splitjoin.vim")
    use("chrisbra/csv.vim")
    use("christoomey/vim-sort-motion")
    use("christoomey/vim-tmux-navigator")
    use("iovis/browsers_castle")
    use("iovis/hubcap.vim")
    use("iovis/jirafa.vim")
    use("iovis/resize.vim")
    use("iovis/substitute.vim")
    use("iovis/tux.vim")
    use("iovis/vimlook")
    use("jparise/vim-graphql")
    use("justinmk/vim-sneak")
    use("kana/vim-textobj-entire")
    use("kana/vim-textobj-indent")
    use("kana/vim-textobj-user")
    use("mbbill/undotree")
    use("moll/vim-bbye")
    use("nvim-lua/plenary.nvim")
    use("pbrisbin/vim-mkdir")
    use("rrethy/nvim-base16")
    use("schickling/vim-bufonly")
    use("tommcdo/vim-lion")
    use("tpope/vim-abolish")
    use("tpope/vim-bundler")
    use("tpope/vim-characterize")
    use("tpope/vim-dadbod")
    use("tpope/vim-dispatch")
    use("tpope/vim-dotenv")
    use("tpope/vim-eunuch")
    use("tpope/vim-fugitive")
    use("tpope/vim-git")
    use("tpope/vim-obsession")
    use("tpope/vim-projectionist")
    use("tpope/vim-ragtag")
    use("tpope/vim-rails")
    use("tpope/vim-rake")
    use("tpope/vim-rbenv")
    use("tpope/vim-repeat")
    use("tpope/vim-rhubarb")
    use("tpope/vim-scriptease")
    use("tpope/vim-speeddating")
    use("tpope/vim-surround")
    use("vim-test/vim-test")
    use("wbthomason/packer.nvim")
    use("wellle/targets.vim")

    use({
      "akinsho/bufferline.nvim",
      config = [[require("plugins.bufferline")]],
      requires = "kyazdani42/nvim-web-devicons",
    })
    use({
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
    })
    use({
      "feline-nvim/feline.nvim",
      config = [[require("plugins.feline")]],
    })
    use({
      "ibhagwan/fzf-lua",
      config = [[require("plugins.fzf-lua")]],
      requires = {
        "vijaymarupudi/nvim-fzf",
        "kyazdani42/nvim-web-devicons",
        {
          "junegunn/fzf",
          run = function()
            vim.fn["fzf#install"]()
          end,
        },
      },
    })
    -- use {
    --   "folke/todo-comments.nvim",
    --   config = [[require("plugins.todo-comments")]],
    --   requires = "nvim-lua/plenary.nvim"
    -- }
    use({
      "folke/zen-mode.nvim",
      config = [[require("plugins.zen-mode")]],
    })
    -- use({
    --   "folke/trouble.nvim",
    --   config = [[require("plugins.trouble")]],
    --   requires = "kyazdani42/nvim-web-devicons",
    -- })
    use({
      "kevinhwang91/nvim-bqf",
      config = [[require("plugins.nvim-bqf")]],
    })
    use({
      "kyazdani42/nvim-tree.lua",
      config = [[require("plugins.nvim-tree")]],
      requires = "kyazdani42/nvim-web-devicons",
    })
    -- TODO: seems to cause issues with Telescope's which_key
    -- use({
    --   "kylechui/nvim-surround",
    --   config = [[require("plugins.nvim-surround")]],
    -- })
    use({
      "lewis6991/gitsigns.nvim",
      config = [[require("plugins.gitsigns")]],
      requires = "nvim-lua/plenary.nvim",
    })
    use({
      "numToStr/Comment.nvim",
      config = [[require("plugins.comment")]],
    })
    use({
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      config = [[require("plugins.telescope")]],
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
    })
    use({
      "nvim-treesitter/nvim-treesitter",
      config = [[require("plugins.treesitter")]],
      run = ":TSUpdate",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "rrethy/nvim-treesitter-endwise",
      },
    })
    use({
      "windwp/nvim-autopairs",
      config = [[require("plugins.autopairs")]],
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      config = [[require("plugins.lsp")]],
      requires = {
        "b0o/schemastore.nvim",
        "simrat39/rust-tools.nvim",
        {
          "jose-elias-alvarez/null-ls.nvim",
          config = [[require("plugins.null_ls")]],
        },
        {
          "williamboman/mason.nvim",
          requires = {
            "williamboman/mason-lspconfig.nvim",
          },
        },
      },
    })

    -- nvim-cmp
    use({
      "hrsh7th/nvim-cmp",
      config = [[require("plugins.cmp")]],
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
        "petertriho/cmp-git",
        "quangnguyen30192/cmp-nvim-tags",
        "saadparwaiz1/cmp_luasnip",
      },
    })

    -- snippets
    use({
      "L3MON4D3/LuaSnip",
      config = [[require("plugins.luasnip")]],
    })
  end,
  config = {
    profile = {
      enable = false, -- Turn to true and run :PackerProfile
      threshold = 1,
    },
  },
})
