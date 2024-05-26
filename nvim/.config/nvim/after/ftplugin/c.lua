local u = require("config.utils")

vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buffer = true })
elseif u.current_file():match("keyboards/") then
  ---- QMK
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "d<cr>", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
elseif u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c,h -c clear just run<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- make run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- make<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c -c clear make<cr>", { buffer = true })
end
