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
    "copilotpanel",
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

---- Auto create intermediate directories if they don't exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Create intermediate directories if they don't exist",
  group = config_augroup,
  pattern = "*",
  callback = function(ctx)
    local ignored_filetypes = {
      "oil",
    }

    if in_ignored_filetypes(ignored_filetypes) then
      return
    end

    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
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

---- Remove highlight after search
-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--   desc = "Remove highlight after search",
--   group = config_augroup,
--   callback = function()
--     if not vim.g.hlsearch then
--       return
--     end
--
--     if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
--       vim.schedule(function()
--         vim.cmd.nohlsearch()
--       end)
--     end
--   end,
-- })

---- Force commentstring padding
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   desc = "Force commentstring to include spaces",
--   group = config_augroup,
--   callback = function(event)
--     local comment_string = vim.bo[event.buf].commentstring
--     vim.bo[event.buf].commentstring = comment_string:gsub("(%S)%%s", "%1 %%s"):gsub("%%s(%S)", "%%s %1")
--   end,
-- })
