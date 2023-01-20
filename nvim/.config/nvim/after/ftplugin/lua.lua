local u = require("config.utils")

u.lsp_autoformat()

vim.keymap.set("n", "<leader>so", "<cmd>source %<cr>", { buffer = true })

-- Re-source `config()` for the current plugin
vim.keymap.set("n", "<leader>sr", function()
  -- Get the name of the current buffer's file
  local filename = vim.api.nvim_buf_get_name(0)
  local base_name = string.match(filename, "([^/\\]+)%.[^.]+$")

  -- Require the plugin and run its config function
  print(string.format("Reloading %s", base_name))
  require("plugins." .. base_name).config()
end, { buffer = true })
