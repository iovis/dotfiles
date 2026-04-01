----EmmyLua Annotations: https://luals.github.io/wiki/annotations/
local u = require("config.utils")

-- Allow `---` to continue as comment
vim.bo.comments = ":---,:--"

----Bindings
vim.keymap.set({ "n", "x" }, "<leader>so", ":source<cr>", {
  desc = "Source file",
  buf = 0,
})

vim.keymap.set("n", "<leader>si", ":.lua<cr>", {
  desc = "Execute line",
  buf = 0,
})

vim.keymap.set("n", "s<cr>", ":10R source<cr>", { buf = 0 })
vim.keymap.set("x", "<leader>sp", ":<c-u>10R '<,'>source<cr>", { buf = 0 })

if u.current_file():match("plugins/") then
  ----Re-source `config()` for the current plugin
  vim.keymap.set("n", "<leader>so", function()
    -- Get the name of the current buffer's file
    local plugin = "plugins." .. vim.fn.expand("%:t:r")

    -- Remove it from cache
    package.loaded[plugin] = nil

    -- Require the plugin and run its config function
    require(plugin).config()

    print(string.format("Reloaded %s", plugin))
  end, { buf = 0 })
elseif u.current_file():match("hammerspoon/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux hs<cr>", { buf = 0 })
elseif u.current_file():match("muxi/") then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux muxi init<cr>", { buf = 0 })
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
