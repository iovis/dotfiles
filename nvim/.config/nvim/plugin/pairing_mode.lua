local pairing = false
local linehl = vim.api.nvim_get_hl(0, { name = "CursorLine" }) --[[@as vim.api.keyset.highlight]]
local colhl = vim.api.nvim_get_hl(0, { name = "CursorColumn" }) --[[@as vim.api.keyset.highlight]]
local pairhl = { bg = "#292c3d" } -- `pastel lighten 0.05 '#1f212e'`

vim.api.nvim_create_user_command("PairingMode", function()
  pairing = not pairing

  if pairing then
    vim.api.nvim_set_hl(0, "CursorLine", pairhl)
    vim.api.nvim_set_hl(0, "CursorColumn", pairhl)

    vim.cmd("set norelativenumber")
    vim.cmd("set cursorcolumn")
  else
    vim.api.nvim_set_hl(0, "CursorLine", linehl)
    vim.api.nvim_set_hl(0, "CursorColumn", colhl)

    vim.cmd("set relativenumber")
    vim.cmd("set nocursorcolumn")
  end
end, {})

vim.keymap.set("n", "yoe", ":PairingMode<cr>")
