require("nvim-surround").setup({
  delimiters = {
    pairs = {
      ["*"] = { "*", "*" },
      ["_"] = { "_", "_" },
      ["/"] = { "/", "/" },
    },
  },
})

vim.keymap.set("n", [[<leader>"]], [[cs'"]], { remap = true })
vim.keymap.set("n", [[<leader>']], [[cs"']], { remap = true })
