local tux = require("tux")

vim.keymap.set("n", "s<cr>", "<cmd>Tux %<cr>", { buffer = true })
vim.keymap.set("n", "m<cr>", "<cmd>!chmod +x %<cr>", { buffer = true })

---- yabai
if vim.fn.expand("%"):match("yabai/") then
  vim.keymap.set("n", "s<cr>", function()
    tux.window("yabai --restart-service", {
      detached = true,
      select = false,
      name = nil,
    })
  end, { buffer = true })

  vim.keymap.set("n", "<leader>so", function()
    tux.window("yabai --restart-service", {
      detached = true,
      select = false,
      name = nil,
    })
  end, { buffer = true })
end
