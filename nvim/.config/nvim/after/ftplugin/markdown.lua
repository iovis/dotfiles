local u = require("config.utils")

vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = "n" -- Keep current line concealed in normal mode
vim.opt_local.spelllang = "en_us"
vim.opt_local.spell = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

vim.opt_local.formatoptions:append("tcroqnl1jp")

-- Allow *, -, +, ?, > to auto-create the character on line change
vim.opt_local.comments = "b:*,b:- [ ],b:- [x],b:-,n:>"

---An incredibly over-engineered task toggler to learn a bit of Treesitter
---@param mode string
function ToggleCheckbox(mode)
  local start_row = vim.fn.line("'[") - 1
  local end_row = start_row + 1

  -- If visual mode, take range instead
  if mode:find("[vV]") then
    -- `< and `> won't work here because you have to exit visual mode
    -- for those to get registered
    local range = { vim.fn.getpos("v")[2], vim.fn.line(".") }
    start_row = math.min(unpack(range)) - 1
    end_row = math.max(unpack(range))
  end

  -- NOTE: this would look for /queries/markdown_inline/images.scm
  --   local query = vim.treesitter.query.get('markdown_inline', 'images')
  local tasks = vim.treesitter.query.parse(
    "markdown",
    [[
      ;;query
      (list_item [
        (task_list_marker_checked)   @checked
        (task_list_marker_unchecked) @unchecked])
    ]]
  )

  -- Run query in the current line
  for id, node in tasks:iter_captures(u.ts.root_node(), 0, start_row, end_row) do
    local capture = tasks.captures[id]
    local node_row = node:range()

    -- The query gets weird with nested checkboxes for some reason
    if node_row < start_row or node_row > end_row then
      -- vim.print(vim.treesitter.get_node_text(node, 0))
      goto continue
    end

    if capture == "checked" then
      u.ts.replace(node, "[ ]")
    elseif capture == "unchecked" then
      u.ts.replace(node, "[x]")
    end

    ::continue::
  end
end

vim.keymap.set("n", "yox", function()
  -- Setting 'operatorfunc' allows for dot-repeats
  -- See: https://gist.github.com/kylechui/a5c1258cd2d86755f97b10fc921315c3
  vim.opt.operatorfunc = "v:lua.ToggleCheckbox"

  -- Sending `g@` back would wait for a motion.
  -- Giving `l` keeps the cursor in place
  return "g@l"
end, { buf = 0, expr = true, desc = "Toggle checkbox" })

vim.keymap.set("x", "X", function()
  ToggleCheckbox(vim.fn.mode())
end, { buf = 0, desc = "Toggle checkbox" })
