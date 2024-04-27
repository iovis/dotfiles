----EmmyLua Annotations: https://luals.github.io/wiki/annotations/
----plenary.nvim test harness: https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md

-- Allow `---` to continue as comment
vim.bo.comments = ":---,:--"

----Bindings
vim.keymap.set({ "n", "x" }, "<leader>so", ":source<cr>", {
  desc = "Source file",
  buffer = true,
})

vim.keymap.set("n", "s<cr>", ":10R source<cr>", { buffer = true })
vim.keymap.set("x", "<leader>sp", ":<c-u>10R '<,'>source<cr>", { buffer = true })

if vim.fn.expand("%"):match("_spec.lua") then
  -- vim.keymap.set("n", "<leader>so", "<cmd>Tux nvimtest %<cr>", { buffer = true, desc = "Run test" })
  -- vim.keymap.set("n", "<leader>sa", "<cmd>Tux nvimtest<cr>", { buffer = true, desc = "Run test suite" })
  -- vim.keymap.set("n", "s<cr>", "<cmd>Tux nvimtest %<cr>", { buffer = true, desc = "Run test" })
elseif vim.fn.expand("%"):match("plugins/") then
  ----Re-source `config()` for the current plugin
  vim.keymap.set("n", "<leader>so", function()
    -- Get the name of the current buffer's file
    local plugin = "plugins." .. vim.fn.expand("%:t:r")

    -- Remove it from cache
    package.loaded[plugin] = nil

    -- Require the plugin and run its config function
    require(plugin).config()

    print(string.format("Reloaded %s", plugin))
  end, { buffer = true })
end

----Surround debug
local ok, surround = pcall(require, "nvim-surround") -- To not break plenary.test_harness
if not ok then
  return
end

surround.buffer_setup({
  surrounds = {
    d = {
      add = { "vim.print(", ")" },
      find = "vim.print%b()",
      delete = "^(vim.print%()().-(%))()$",
    },
  },
})
