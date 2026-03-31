local config_augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

---Check if current buffer is in ignored filetypes
---@param ignored_filetypes string[]
---@return boolean
local function in_ignored_filetypes(ignored_filetypes)
  return vim.bo.filetype and vim.tbl_contains(ignored_filetypes, vim.bo.filetype)
end

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
    local ignored_filetypes = {
      "oil",
    }

    if in_ignored_filetypes(ignored_filetypes) then
      return
    end

    vim.cmd("silent! wall ++p")
  end,
})

---- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Clean trailing whitespace",
  group = config_augroup,
  callback = function()
    vim.cmd([[normal! m`]])
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.cmd([[normal! ``]])
  end,
})

---- Go to last known position when open a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Go to last known position of a buffer",
  group = config_augroup,
  callback = function()
    local ignored_filetypes = {
      "fugitive",
      "git",
      "gitcommit",
    }

    if in_ignored_filetypes(ignored_filetypes) then
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
    "dbout",
    "diff",
    "fugitiveblame",
    "gitsigns-blame",
    "help",
    "httpResult",
    "notify",
    "qf",
    "redir",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      nowait = true,
    })
  end,
})

---- Map [q] to close if reading from STDIN
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.v.argv[3] == "-" then
      vim.keymap.set("n", "q", "<cmd>qa!<cr>", {
        buffer = true,
        nowait = true,
      })
    end
  end,
})

---- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight on yank",
  group = config_augroup,
  pattern = "*",
  callback = function()
    vim.hl.on_yank({
      -- higroup = "HighlightedYankRegion",
      timeout = 75,
    })
  end,
})

---- Terminal mode settings
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Terminal settings",
  group = config_augroup,
  pattern = "*",
  callback = function()
    vim.cmd.startinsert()

    vim.keymap.set("n", "<down>", "i<down>", { buffer = true })
    vim.keymap.set("n", "<left>", "i<left>", { buffer = true })
    vim.keymap.set("n", "<right>", "i<right>", { buffer = true })
    vim.keymap.set("n", "<up>", "i<up>", { buffer = true })
  end,
})
