local tux = require("tux")
local u = require("config.utils")

vim.bo.commentstring = "// %s"
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buf = 0 })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buf = 0 })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buf = 0 })
elseif u.current_file():match("_test.c$") then
  vim.keymap.set("n", "<leader>sa", "<cmd>Tux just test<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just test<cr>", { buf = 0 })

  local suite_name = u.current_file():match("(%w+)_test.c$")
  vim.keymap.set("n", "<leader>so", ("<cmd>Tux just test --filter '%s/*'<cr>"):format(suite_name), { buf = 0 })
  vim.keymap.set("n", "s<cr>", ("<cmd>Tux just test --filter '%s/*'<cr>"):format(suite_name), { buf = 0 })

  -- TODO: use treesitter to extract the suite_name/test_name
  vim.keymap.set("n", "<leader>si", "<cmd>Tux just test --filter " .. "<cr>", { buf = 0 })
elseif vim.uv.cwd():match("qmk_userspace") then
  if u.current_file():match("keyboards/") then
    vim.keymap.set("n", "<leader>S", function()
      -- keyboards/(boardsource/unicorne)/keymaps/...
      local keyboard = u.current_file():match([[keyboards/(.*)/keymaps]])
      u.ui.float_terminal("just choose " .. keyboard)
    end, { buf = 0 })
  end

  vim.keymap.set("n", "s<cr>", function()
    u.ui.float_terminal("just run")
  end, { buf = 0 })

  vim.keymap.set("n", "m<cr>", function()
    u.ui.float_terminal("just flash")
  end, { buf = 0 })

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
elseif u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buf = 0 })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c,h -c clear just run<cr>", { buf = 0 })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux c23 -o %:.:r %:. && ./%:.:r && rm %:.:r<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux c23 -o %:.:r %:.<cr>", { buf = 0 })
end
