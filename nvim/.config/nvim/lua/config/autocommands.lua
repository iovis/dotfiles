local config_augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

---- Reload the file when changed from elsewhere
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = config_augroup,
  command = "checktime",
  desc = "Refresh buffer if changes detected",
})

---- Resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  group = config_augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits on window resize",
})

---- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = config_augroup,
  callback = function()
    vim.cmd("silent! wall")
  end,
  desc = "Autosave on focus lost",
})

---- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = config_augroup,
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
  desc = "Clean trailing whitespace",
})

---- Go to last known position when open a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = config_augroup,
  callback = function()
    -- Remove some filetypes
    local filetype = vim.bo.filetype

    if filetype == "fugitive" or filetype == "git" or filetype == "gitcommit" then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last known position of a buffer",
})

---- Close some filetypes with [q]
vim.api.nvim_create_autocmd("FileType", {
  group = config_augroup,
  pattern = {
    "fugitiveblame",
    "help",
    "lspsagaoutline",
    "man",
    "qf",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

---- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = config_augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "HighlightedYankRegion",
      timeout = 75,
    })
  end,
})

---- Auto create intermediate directories if they don't exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = config_augroup,
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})
