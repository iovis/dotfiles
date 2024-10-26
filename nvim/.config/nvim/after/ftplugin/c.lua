local u = require("config.utils")

vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buffer = true })
elseif u.current_file():match("unicorne/") then
  ---- QMK
  vim.keymap.set("n", "<leader>S", "<cmd>Tuxpopup just setup<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile flash<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
  vim.keymap.set("n", "d<cr>", "<cmd>silent !tmux new-window -Sn qmk -c ../qmk_firmware<cr>", { buffer = true })
  vim.keymap.set("n", "S", "<cmd>10sp symbols.txt<cr>", { buffer = true })
elseif u.current_file():match("voyager/") then
  ---- ZSA
  vim.keymap.set("n", "<leader>S", "<cmd>Tuxpopup just vsetup<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just vcompile vflash<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just vflash<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
  vim.keymap.set("n", "d<cr>", "<cmd>silent !tmux new-window -Sn zsa -c ../zsa_firmware<cr>", { buffer = true })
  vim.keymap.set("n", "S", "<cmd>10sp symbols.txt<cr>", { buffer = true })
elseif u.has_justfile() then
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c,h -c clear just run<cr>", { buffer = true })
else
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- make run<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- make<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>sw", "<cmd>Tux w -e c -c clear make<cr>", { buffer = true })
end
