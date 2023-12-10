local tux = require("tux")

---- skhd
if vim.fn.expand("%"):match("skhd/") then
  vim.keymap.set("n", "<leader>so", function()
    tux.window("skhd --restart-service", {
      detached = true,
      select = false,
      name = nil,
    })
  end, { buffer = true })
end
