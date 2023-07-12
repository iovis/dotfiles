local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
    vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  dev = {
    path = "~/Sites/vim/",
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
vim.keymap.set("n", "<leader>up", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>")
-- vim.keymap.set("n", "<leader>pi", "<cmd>Lazy restore<cr>")
