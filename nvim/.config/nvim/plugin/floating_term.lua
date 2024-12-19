---Open Floating Terminal
---@param bufnr? integer
local function floating_term(bufnr)
  local win_opts = {
    width = 0.75,
    height = 0.66,
  }

  local is_valid_buffer = bufnr and vim.api.nvim_buf_is_valid(bufnr)

  if not is_valid_buffer then
    bufnr = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * win_opts.width)
  local height = math.floor(vim.o.lines * win_opts.height)

  vim.api.nvim_open_win(bufnr --[[@as integer]], true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor(vim.o.columns / 2 - width / 2 - 3),
    row = math.floor(vim.o.lines / 2 - height / 2 - 2),
    style = "minimal",
    border = "rounded",
  })

  if is_valid_buffer then
    vim.cmd.startinsert()
  else
    vim.cmd.terminal()
  end

  return bufnr
end

local buffer = nil
vim.api.nvim_create_user_command("FloatTerm", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd.fclose()
  else
    buffer = floating_term(buffer)
  end
end, {})

vim.keymap.set({ "t", "n" }, [[<c-_>]], "<cmd>FloatTerm<cr>", {
  desc = "Open floating terminal",
})
