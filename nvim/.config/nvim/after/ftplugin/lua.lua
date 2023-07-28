----Annotations: https://github.com/LuaLS/lua-language-server/wiki/Annotations

----Bindings
if vim.fn.expand("%"):match("_spec.lua") then
  vim.keymap.set("n", "<leader>so", ":PlenaryBustedFile %<cr>", { buffer = true, desc = "Run test" })

  vim.keymap.set("n", "<leader>sa", function()
    vim.cmd.PlenaryBustedDirectory("tests/")
  end, { buffer = true, desc = "Run test" })
else
  vim.keymap.set("n", "<leader>so", function()
    vim.cmd.source("%")
    -- print("File sourced")
  end, { buffer = true, desc = "Source file" })

  vim.keymap.set("x", "<leader>so", ":source<cr>", { buffer = true, desc = "Evaluate lua range" })

  vim.keymap.set("n", "<leader>sp", ":R source<cr>", { buffer = true })
  vim.keymap.set("x", "<leader>sp", ":<c-u>R '<,'>source<cr>", { buffer = true })
end

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

----Surround debug
require("nvim-surround").buffer_setup({
  surrounds = {
    ["d"] = {
      add = { "vim.print(", ")" },
      find = "vim.print%b()",
      delete = "^(vim.print%()().-(%))()$",
    },
  },
})
