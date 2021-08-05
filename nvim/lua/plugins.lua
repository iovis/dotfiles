-- Ensure packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

-- Compile plugins when file is changed
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

-- plugins
require('packer').startup(function()
  use 'andrewradev/splitjoin.vim'
  use 'benekastah/neomake'
  use 'chiel92/vim-autoformat'
  use 'chrisbra/csv.vim'
  use 'christoomey/vim-sort-motion'
  use 'christoomey/vim-tmux-navigator'
  use 'folke/zen-mode.nvim'
  use 'honza/vim-snippets'
  use 'iovis/browsers_castle'
  use 'iovis/hubcap.vim'
  use 'iovis/jirafa.vim'
  use 'iovis/resize.vim'
  use 'iovis/substitute.vim'
  use 'iovis/tux.vim'
  use 'iovis/vimlook'
  use 'jparise/vim-graphql'
  use 'junegunn/fzf.vim'
  use 'junegunn/vim-peekaboo'
  use 'justinmk/vim-sneak'
  use 'kana/vim-textobj-entire'
  use 'kana/vim-textobj-indent'
  use 'kana/vim-textobj-user'
  use 'kevinhwang91/nvim-bqf'
  use 'machakann/vim-highlightedyank'
  use 'mattn/emmet-vim'
  use 'mbbill/undotree'
  use 'moll/vim-bbye'
  use 'neoclide/coc-neco' -- uses neco-vim
  use 'norcalli/nvim-base16.lua'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use 'pbrisbin/vim-mkdir'
  use 'raimondi/delimitMate'
  use 'schickling/vim-bufonly'
  use 'shougo/neco-vim'
  -- use 'sirver/ultisnips'
  use 'tommcdo/vim-lion'
  use 'tpope/vim-abolish'
  use 'tpope/vim-bundler'
  use 'tpope/vim-characterize'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dadbod'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-dotenv'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-git'
  use 'tpope/vim-obsession'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-ragtag'
  use 'tpope/vim-rails'
  use 'tpope/vim-rake'
  use 'tpope/vim-rbenv'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-scriptease'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'wbthomason/packer.nvim'
  use 'wellle/targets.vim'

  use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'hoob3rt/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'neoclide/coc.nvim', branch = 'release'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
