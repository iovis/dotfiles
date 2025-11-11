local resize = {}

local function is_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(direction)
end

function resize.run(command, sign, amount)
  vim.cmd(string.format("silent! %s %s%d", command, sign, math.abs(amount)))
end

function resize.up(amount)
  local sign = is_edge("k") and "-" or "+"
  resize.run("resize", sign, amount)
end

function resize.down(amount)
  local sign = is_edge("j") and "-" or "+"
  resize.run("resize", sign, amount)
end

function resize.left(amount)
  local sign = is_edge("h") and "-" or "+"
  resize.run("vertical resize", sign, amount)
end

function resize.right(amount)
  local sign = is_edge("l") and "-" or "+"
  resize.run("vertical resize", sign, amount)
end

vim.keymap.set("n", "<m-up>", function()
  resize.up(5)
end, { desc = "Resize window up" })

vim.keymap.set("n", "<m-down>", function()
  resize.down(5)
end, { desc = "Resize window down" })

vim.keymap.set("n", "<m-left>", function()
  resize.left(20)
end, { desc = "Resize window left" })

vim.keymap.set("n", "<m-right>", function()
  resize.right(20)
end, { desc = "Resize window right" })

vim.keymap.set("n", "<c-m-up>", function()
  resize.up(1)
end, { desc = "Resize window up" })

vim.keymap.set("n", "<c-m-down>", function()
  resize.down(1)
end, { desc = "Resize window down" })

vim.keymap.set("n", "<c-m-left>", function()
  resize.left(1)
end, { desc = "Resize window left" })

vim.keymap.set("n", "<c-m-right>", function()
  resize.right(1)
end, { desc = "Resize window right" })
