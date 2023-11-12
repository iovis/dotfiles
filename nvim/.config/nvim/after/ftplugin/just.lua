vim.b.editorconfig = false

vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

vim.keymap.set("n", "s<cr>", function()
  -- Examples:
  --
  -- init:
  -- build: init
  -- run file="default": build
  local command_pattern = [[^\(\w\+\).*:\( \|$\)]]

  local command = vim.fn.matchlist( -- Get matches of a pattern in a given text
    vim.fn.getline( -- Returns the contents of a line given its number
      vim.fn.search( -- Returns line number of match or 0 if it doesn't exist
        command_pattern,
        "bcnW"
        -- 'b' -> search backward
        -- 'c' -> accept a match at the cursor position
        -- 'n' -> don't move the cursor
        -- 'W' -> don't wrap around the file
      )
    ),
    command_pattern
  )

  if vim.tbl_isempty(command) then
    vim.notify("No recipe", vim.log.levels.WARN)
    return
  end

  vim.cmd.Tux(("just %s"):format(command[2]))
end, { buffer = true, desc = "Run current recipe" })
