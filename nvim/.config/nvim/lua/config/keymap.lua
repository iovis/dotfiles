---- Disable Space to not conflict with Leader
vim.keymap.set("n", "<Space>", "<Nop>")

---- Insert mode
-- Exit
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "KJ", "<esc>")
vim.keymap.set("i", "Kj", "<esc>")

-- Quick expansions
vim.keymap.set("i", ",,", "<c-o>A,")
vim.keymap.set("i", ";;", "<c-o>A;")

vim.keymap.set("i", "<m-+>", "]")
vim.keymap.set("i", "<m-ç>", "}")
vim.keymap.set("i", "<m-ñ>", "~")

-- Movement
vim.keymap.set("i", "<m-left>", "<s-left>")
vim.keymap.set("i", "<m-right>", "<s-right>")

vim.keymap.set("i", "<c-a>", "<home>")
vim.keymap.set("i", "<c-e>", "<end>")

vim.keymap.set("i", "<m-O>", "<esc>O")
vim.keymap.set("i", "<m-o>", "<esc>o")

----------------------------------------------

vim.keymap.set("n", "+t", "<c-w>T")
vim.keymap.set("n", "<leader>P", ":lua =")
vim.keymap.set("n", "<leader>uf", "<cmd>EditFtplugin<cr>")
vim.keymap.set("n", "<leader>ñ", "<cmd>nohlsearch<cr>")

---- Quick `R`
vim.keymap.set("n", "_", ":R lua=")

---- Notes
vim.keymap.set("n", "<leader>n", ":e notes/index.md<cr>", { silent = true })
vim.keymap.set("n", "<leader>N", [[:execute "e notes/" . strftime('%F') . ".md"<cr>]], { silent = true })

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

---- Terminal mode
vim.keymap.set("t", "kj", [[<c-\><c-n>]])

vim.keymap.set("t", "<c-h>", [[<c-\><c-n><C-w>h]])
vim.keymap.set("t", "<c-j>", [[<c-\><c-n><C-w>j]])
vim.keymap.set("t", "<c-k>", [[<c-\><c-n><C-w>k]])
vim.keymap.set("t", "<c-l>", [[<c-\><c-n><C-w>l]])
