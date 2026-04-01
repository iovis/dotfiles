---Open Floating Terminal
---@param bufnr? integer
local function floating_term(bufnr)
  local is_valid_buffer = bufnr and vim.api.nvim_buf_is_valid(bufnr)

  if not is_valid_buffer then
    bufnr = vim.api.nvim_create_buf(false, true)
  end

  Snacks.win({
    buf = bufnr,
    width = 0.75,
    height = 0.66,
    border = "rounded",
    on_win = function()
      if is_valid_buffer then
        vim.cmd.startinsert()
      else
        vim.cmd.terminal()
      end
    end,
  })

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

vim.keymap.set({ "t", "n" }, "<m-/>", "<cmd>FloatTerm<cr>", {
  desc = "Open floating terminal",
})
