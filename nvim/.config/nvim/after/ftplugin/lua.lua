----EmmyLua Annotations: https://luals.github.io/wiki/annotations/
----plenary.nvim test harness: https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md
local u = require("config.utils")

-- Allow `---` to continue as comment
vim.bo.comments = ":---,:--"

----Bindings
vim.keymap.set({ "n", "x" }, "<leader>so", ":source<cr>", {
  desc = "Source file",
  buffer = true,
})

vim.keymap.set("n", "<leader>si", ":.lua<cr>", {
  desc = "Execute line",
  buffer = true,
})

vim.keymap.set("n", "s<cr>", ":10R source<cr>", { buffer = true })
vim.keymap.set("x", "<leader>sp", ":<c-u>10R '<,'>source<cr>", { buffer = true })

if u.current_file():match("_spec.lua") then
  -- vim.keymap.set("n", "<leader>so", "<cmd>Tux nvimtest %<cr>", { buffer = true, desc = "Run test" })
  -- vim.keymap.set("n", "<leader>sa", "<cmd>Tux nvimtest<cr>", { buffer = true, desc = "Run test suite" })
  -- vim.keymap.set("n", "s<cr>", "<cmd>Tux nvimtest %<cr>", { buffer = true, desc = "Run test" })
elseif u.current_file():match("plugins/") then
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
elseif u.current_file():match("hammerspoon/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux hs<cr>", { buffer = true })
end

----Surround debug
vim.b.minisurround_config = {
  custom_surroundings = {
    d = {
      input = { "vim.print%(().-()%)" },
      output = { left = "vim.print(", right = ")" },
    },
    s = {
      input = { "%[%[().-()%]%]" },
      output = { left = "[[", right = "]]" },
    },
  },
}
