-- Taken from: https://github.com/stevearc/oil.nvim
--
-- ```sh
-- nvim -u repro.lua
-- ```
--

-- set stdpaths to use .repro
local root = vim.fn.fnamemodify("./.repro", ":p")
for _, name in ipairs({ "config", "data", "state", "runtime", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

-- Opts
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "-", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>h", "<c-w>s")
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>ñ", "<cmd>noh<cr><cmd>echon<cr>")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "ñ", "/")

-- install plugins
local plugins = {
  -- {
  --   "ibhagwan/fzf-lua",
  --   config = function()
  --     local fzf = require("fzf-lua")
  --     fzf.setup({})
  --     vim.keymap.set("n", "<leader>o", fzf.files)
  --   end
  -- },
}

require("lazy").setup(plugins, { root = root .. "/plugins" })
