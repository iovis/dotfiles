-- Taken from: https://github.com/stevearc/oil.nvim
--
-- ```sh
-- nvim -u repro.lua
-- ```
--

-- Set stdpaths to use $DOTFILES/.repro/
local root = vim.fn.resolve(vim.env.DOTFILES .. "/.repro")
for _, name in ipairs({ "config", "data", "state", "runtime", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- Bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.runtimepath:prepend(lazypath)

-- Opts
vim.g.mapleader = " "
vim.o.cursorline = true
vim.o.inccommand = "split"
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.wrap = false

-- Keymap
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "-", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>e", ":e!<space>")
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>h", "<c-w>s")
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>;", "<cmd>noh<cr><cmd>echon<cr>")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "<bs>", "<c-^>")
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set({ "n", "x" }, ":", ";")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

-- Install plugins
local plugins = {
  -- {
  --   "ibhagwan/fzf-lua",
  --   config = function()
  --     local fzf = require("fzf-lua")
  --     fzf.setup({})
  --     vim.keymap.set("n", "<leader>o", fzf.files)
  --   end,
  -- },
  -- {
  --   "iovis/oil.nvim",
  --   dev = true,
  --   lazy = false,
  --   keys = {
  --     { "-", "<cmd>Oil --float<cr>" },
  --     { "_", "<cmd>Oil<cr>" },
  --   },
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- },
}

require("lazy").setup(plugins, {
  root = root .. "/plugins",
  install = {
    colorscheme = { "default" },
  },
  dev = {
    path = vim.fn.resolve(vim.env.PROJECT_HOME .. "/vim"),
  },
})
