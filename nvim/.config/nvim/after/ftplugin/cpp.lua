local u = require("config.utils")

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

if vim.uv.cwd():match("qmk_userspace") then
  if u.current_file():match("keyboards/") then
    vim.keymap.set("n", "<leader>S", function()
      -- keyboards/(boardsource/unicorne)/keymaps/...
      local keyboard = u.current_file():match([[keyboards/(.*)/keymaps]])
      tux.popup("just setup " .. keyboard)
    end, { buffer = true })
  end

  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>dS", "<cmd>60vs keymap.md<cr>", { buffer = true })

  vim.keymap.set("n", "s?", function()
    vim.notify(u.system({
      "qmk",
      "config",
      "user.keyboard",
    }))
  end, { buffer = true })

  vim.keymap.set("n", "d<cr>", function()
    tux.window("qmk cd", {
      name = "firmware",
      select = true,
    })
  end, { buffer = true })
end
