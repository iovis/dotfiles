local tux = require("tux")
local u = require("config.utils")

vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<leader>al", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buffer = true })
elseif vim.uv.cwd():match("qmk_userspace") then
  vim.keymap.set("n", "<leader>S", function()
    local firmware = "qmk"

    if u.current_file():match("zsa/") then
      firmware = "zsa"
    end

    tux.popup("just setup " .. firmware)
  end, { buffer = true })

  vim.keymap.set("n", "s<cr>", "<cmd>Tuxpopup just compile flash<cr>", { buffer = true })
  vim.keymap.set("n", "m<cr>", "<cmd>Tuxpopup just flash<cr>", { buffer = true })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buffer = true })
  vim.keymap.set("n", "S", "<cmd>15sp keymap.md<cr>", { buffer = true })

  vim.keymap.set("n", "d?", function()
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
