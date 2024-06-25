local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    notify = false,
  },
  dev = {
    path = vim.fn.resolve(vim.env.PROJECT_HOME .. "/vim"),
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  -- diff = {
  --   cmd = "diffview.nvim",
  -- },
  ui = {
    border = "rounded",
  },
})

require("lazy.view.config").keys.profile_filter = "<c-p>"
vim.keymap.set("n", "<leader>p", "<cmd>Lazy<cr>")
