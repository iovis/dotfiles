vim.keymap.set("n", "<Space>", "<Nop>")

vim.keymap.set("n", "<leader>P", ":lua =")
vim.keymap.set("n", "+t", "<c-w>T")
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")

---- Global substitutions
vim.keymap.set({ "n", "x" }, "+g", ":g//<left>")
vim.keymap.set({ "n", "x" }, "+l", ':luado return string.format("%s", line)')
vim.keymap.set({ "n", "x" }, "+v", ":v//<left>")

---- Tmux quick switching
vim.keymap.set("n", "++", "<cmd>TmuxNewSession<cr>")
vim.keymap.set("n", "+<space>", ":TmuxNewSession<space>")
vim.keymap.set("n", "+V", "<cmd>VimPlugin<cr>")

---- Toggle autoformat
vim.keymap.set("n", "<leader>B", function()
  if vim.g.autoformat then
    vim.g.autoformat = false
    print("Autoformat disabled")
  else
    vim.g.autoformat = true
    print("Autoformat enabled")
  end
end, { desc = "Toggle autoformat" })

---- Toggle autotest
vim.keymap.set("n", "+T", function()
  vim.ui.select({ "file", "line", "disable" }, {
    prompt = "RSpec> ",
    format_item = function(item)
      local is_current = ""

      if vim.g.autotest == item or (vim.g.autotest == nil and item == "disable") then
        is_current = " (current)"
      end

      return item .. is_current
    end,
  }, function(choice)
    if choice == "disable" then
      vim.g.autotest = nil
    else
      vim.g.autotest = choice
    end
  end)
end, { desc = "Toggle autotest" })
