local M = {
  "tpope/vim-dadbod",
  cmd = "DB",
}

M.init = function()
  local current_db = function()
    return vim.w.db or vim.fn.DotenvGet("DATABASE_URL")
  end

  vim.keymap.set("n", "d!", ":DB w:db =<space>")
  vim.keymap.set("n", "d<space>", ":DB<space>")

  vim.keymap.set("n", "d<cr>", function()
    vim.cmd.execute(string.format([['TuxBg pgcli %s']], current_db()))
  end, { silent = true, desc = "Open pgcli" })

  vim.keymap.set("n", "d?", function()
    print(current_db())
  end, { desc = "Dadbod current DB" })
end

return M
