local tux = require("tux")
local u = require("config.utils")

vim.bo.commentstring = "// %s"
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buffer = true })
elseif u.current_file():match("_test.c$") then
  vim.keymap.set("n", "<leader>sa", "<cmd>Tux just test<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just test<cr>", { buffer = true })

  local suite_name = u.current_file():match("(%w+)_test.c$")
  vim.keymap.set("n", "<leader>so", ("<cmd>Tux just test --filter '%s/*'<cr>"):format(suite_name), { buffer = true })
  vim.keymap.set("n", "s<cr>", ("<cmd>Tux just test --filter '%s/*'<cr>"):format(suite_name), { buffer = true })

  -- TODO: use treesitter to extract the suite_name/test_name
  vim.keymap.set("n", "<leader>si", "<cmd>Tux just test --filter " .. "<cr>", { buffer = true })
elseif vim.uv.cwd():match("qmk_userspace") then
  if u.current_file():match("keyboards/") then
    vim.keymap.set("n", "<leader>S", function()
      -- keyboards/(boardsource/unicorne)/keymaps/...
      local keyboard = u.current_file():match([[keyboards/(.*)/keymaps]])
      tux.popup("just choose " .. keyboard)
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
elseif u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c,h -c clear just run<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux c23 -o %:.:r %:. && ./%:.:r && rm %:.:r<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux c23 -o %:.:r %:.<cr>", { buffer = true })
end
