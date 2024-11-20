vim.keymap.set("n", "s<cr>", "<cmd>Tux bun %:.<cr>", { buffer = true })

local u = require("config.utils")

---Mark function as `async` if `await` is typed
---From: https://www.youtube.com/watch?v=_m7amJZpQQ8
local function add_async()
  -- Type `t` again because we swallowed it as the trigger
  vim.api.nvim_feedkeys("t", "n", true)

  local bufnr = vim.fn.bufnr()
  local current_col = vim.fn.col(".")

  local text_before_cursor = vim.fn.getline("."):sub(current_col - #" awai", current_col - 1)
  vim.print(text_before_cursor)
  if text_before_cursor ~= " awai" then
    return
  end

  -- `ignore_injections = false` so it works even when injected in other languages
  local current_node = vim.treesitter.get_node({ ignore_injections = false })
  local function_node = u.ts.find_ancestor(current_node, {
    "arrow_function",
    "function_declaration",
    "function",
  })

  if not function_node then
    return
  end

  local function_node_text = vim.treesitter.get_node_text(function_node, bufnr)
  if vim.startswith(function_node_text, "async") then
    return
  end

  local start_row, start_col = function_node:start()
  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, start_row, start_col, { "async " })
end

-- Listen to `t` to check for async
vim.keymap.set("i", "t", add_async, { buffer = true })
