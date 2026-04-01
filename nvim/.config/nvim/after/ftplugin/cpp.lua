local tux = require("tux")
local u = require("config.utils")

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buf = 0 })

if vim.uv.cwd():match("qmk_userspace") then
  if u.current_file():match("keyboards/") then
    vim.keymap.set("n", "<leader>S", function()
      -- keyboards/(boardsource/unicorne)/keymaps/...
      local keyboard = u.current_file():match([[keyboards/(.*)/keymaps]])
      tux.popup("just setup " .. keyboard)
    end, { buf = 0 })
  end

  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just run<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buf = 0 })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>dS", "<cmd>60vs keymap.md<cr>", { buf = 0 })

  vim.keymap.set("n", "s?", function()
    vim.notify(u.system({
      "qmk",
      "config",
      "user.keyboard",
    }))
  end, { buf = 0 })

  vim.keymap.set("n", "d<cr>", function()
    tux.window("qmk cd", {
      name = "firmware",
      select = true,
    })
  end, { buf = 0 })
end
