---- Highlight on yank
local hi = require("user.utils").hi
hi.HighlightedYankRegion = { fg = "#262626", bg = "#8fafd7" }

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlighted_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "HighlightedYankRegion", timeout = 300 })
  end,
})

---- Auto create intermediate directories if they don't exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("autocreate_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})
