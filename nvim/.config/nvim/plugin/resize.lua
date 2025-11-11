local resize = {}

local function is_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(direction)
end

local function sign_for(direction)
  return is_edge(direction) and "-" or "+"
end

function resize.run(command, sign, amount)
  vim.cmd(string.format("silent! %s %s%d", command, sign, math.abs(amount)))
end

function resize.up(amount)
  resize.run("resize", sign_for("k"), amount)
end

function resize.down(amount)
  resize.run("resize", sign_for("j"), amount)
end

function resize.left(amount)
  resize.run("vertical resize", sign_for("h"), amount)
end

function resize.right(amount)
  resize.run("vertical resize", sign_for("l"), amount)
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
