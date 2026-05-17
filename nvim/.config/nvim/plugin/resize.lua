local resize = {}

local function is_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(direction)
end

local opposites = {
  h = "l",
  j = "k",
  k = "j",
  l = "h",
}

local function has_neighbor(direction)
  return not is_edge(direction) or not is_edge(opposites[direction])
end

local function sign_for(direction)
  return is_edge(direction) and "-" or "+"
end

function resize.run(command, direction, amount)
  if not has_neighbor(direction) then
    return
  end

  vim.cmd(string.format("silent! %s %s%d", command, sign_for(direction), math.abs(amount)))
end

function resize.up(amount)
  resize.run("resize", "k", amount)
end

function resize.down(amount)
  resize.run("resize", "j", amount)
end

function resize.left(amount)
  resize.run("vertical resize", "h", amount)
end

function resize.right(amount)
  resize.run("vertical resize", "l", amount)
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
