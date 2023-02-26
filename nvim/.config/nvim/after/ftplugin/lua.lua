----Annotations: https://github.com/LuaLS/lua-language-server/wiki/Annotations

----Bindings
vim.keymap.set("n", "<leader>so", function()
  vim.cmd.source("%")
  print("File sourced")
end, { buffer = true, desc = "Source file" })

vim.keymap.set("x", "<leader>so", ":source<cr>", { buffer = true, desc = "Evaluate lua range" })

----Re-source `config()` for the current plugin
if vim.fn.expand("%"):match("plugins/") then
  vim.keymap.set("n", "<leader>sr", function()
    -- Get the name of the current buffer's file
    local plugin = "plugins." .. vim.fn.expand("%:t:r")

    -- Remove it from cache
    package.loaded[plugin] = nil

    -- Require the plugin and run its config function
    require(plugin).config()

    print(string.format("Reloaded %s", plugin))
  end, { buffer = true })
end
