vim.keymap.set("n", "<leader>so", function()
  vim.cmd.source("%")
  print("File sourced")
end, { buffer = true })

---- Re-source `config()` for the current plugin
-- if string.match(vim.fn.expand("%"), "plugins/") then
--   vim.keymap.set("n", "<leader>sr", function()
--     -- Get the name of the current buffer's file
--     local filename = vim.api.nvim_buf_get_name(0)
--     local base_name = string.match(filename, "([^/\\]+)%.[^.]+$")
--     local name = "plugins." .. base_name
--
--     -- Require the plugin and run its config function
--     require(name).config()
--
--     print(string.format("Reloaded %s", name))
--   end, { buffer = true })
-- end
