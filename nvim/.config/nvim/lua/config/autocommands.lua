local config_augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

---- Reload the file when changed from elsewhere
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Refresh buffer if changes detected",
  group = config_augroup,
  command = "silent! checktime",
})

---- Resize splits if window got resized
-- vim.api.nvim_create_autocmd("VimResized", {
--   desc = "Resize splits on window resize",
--   group = config_augroup,
--   callback = function()
--     vim.cmd("wincmd =")
--   end,
-- })

---- Autosave on focus lost
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  desc = "Autosave on focus lost",
  group = config_augroup,
  callback = function()
    if vim.bo.filetype == "oil" then
      return
    end

    vim.cmd("silent! wall")
  end,
})

---- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Clean trailing whitespace",
  group = config_augroup,
  callback = function()
    vim.cmd([[normal! m`]])
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[normal! ``]])
  end,
})

---- Go to last known position when open a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Go to last known position of a buffer",
  group = config_augroup,
  callback = function()
    local ignore_filetypes = {
      "fugitive",
      "git",
      "gitcommit",
    }

    if vim.bo.filetype and vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

---- Close some filetypes with [q]
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close with [q]",
  group = config_augroup,
  pattern = {
    "checkhealth",
    "dbout",
    "diff",
    "fugitiveblame",
    "git",
    "gitcommit",
    "help",
    "httpResult",
    "lspsagaoutline",
    "notify",
    "qf",
    "redir",
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
  desc = "Highlight on yank",
  group = config_augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      -- higroup = "HighlightedYankRegion",
      timeout = 75,
    })
  end,
})

---- Auto create intermediate directories if they don't exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Create intermediate directories if they don't exist",
  group = config_augroup,
  pattern = "*",
  callback = function(ctx)
    if vim.bo.filetype == "oil" then
      return
    end

    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})

---- Set terminal mode settings
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Set terminal mode settings",
  group = config_augroup,
  pattern = "*",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.cmd.startinsert()
  end,
})
