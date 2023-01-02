local M = {
  "tpope/vim-dadbod",
  cmd = "DB",
}

M.current_db = function()
  return vim.w.db or vim.fn.DotenvGet("DATABASE_URL")
end

M.init = function()
  vim.keymap.set("n", "d!", ":DB w:db =<space>")
  vim.keymap.set("n", "d<space>", ":DB<space>")

  vim.keymap.set("n", "d<cr>", function()
    vim.cmd.execute("'TuxBg pgcli " .. M.current_db() .. "'")
  end, { silent = true, desc = "Open pgcli" })

  vim.keymap.set("n", "d?", function()
    print(M.current_db())
  end, { desc = "Dadbod current DB" })
end

return M
