local u = require("config.utils")
local tux = require("tux")

vim.keymap.set("n", "s<cr>", "<cmd>Tux %<cr>", { buf = 0 })
vim.keymap.set("n", "m<cr>", "<cmd>!chmod +x %<cr>", { buf = 0 })

---- yabai
if u.current_file():match("yabai/") then
  vim.keymap.set("n", "s<cr>", function()
    tux.window("yabai --restart-service", {
      detached = true,
      select = false,
      name = nil,
    })
  end, { buf = 0 })

  vim.keymap.set("n", "<leader>so", function()
    tux.window("yabai --restart-service", {
      detached = true,
      select = false,
      name = nil,
    })
  end, { buf = 0 })
end
