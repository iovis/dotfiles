vim.b.editorconfig = false

vim.bo.commentstring = "# %s"
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

vim.keymap.set("n", "s<cr>", function()
  -- Examples:
  --
  -- init:
  -- @build: init
  -- run file="default": build

  -- stylua: ignore
  local command = vim.fn.getline( -- Returns the contents of a line given its number
    vim.fn.search( -- Returns line number of match or 0 if it doesn't exist
      [[\v^[@]?\w+.*:( |$)]],
      "bcnW"
      -- 'b' -> search backward
      -- 'c' -> accept a match at the cursor position
      -- 'n' -> don't move the cursor
      -- 'W' -> don't wrap around the file
    )
  ):match("^@?([%w_]+)")

  if command then
    vim.cmd.Tux(("just %s"):format(command))
  else
    vim.notify("No recipe", vim.log.levels.WARN)
  end
end, { buffer = true, desc = "Run current recipe" })
