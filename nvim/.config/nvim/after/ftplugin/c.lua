local tux = require("tux")
local u = require("config.utils")

vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<leader>al", "<cmd>LspClangdSwitchSourceHeader<cr>", { buf = 0 })

---- runnables
if u.current_file():match("ext/") then
  ---- Ruby C Extension
  vim.keymap.set("n", "m<cr>", "<cmd>Tux bear -- rake<cr>", { buf = 0 })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux bear -- rake<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux watchexec -e c,h,rb -c clear -- bear -- rake<cr>", { buf = 0 })
elseif vim.uv.cwd():match("qmk_userspace") then
  if u.current_file():match("keyboards/") then
    vim.keymap.set("n", "<leader>S", function()
      -- keyboards/(boardsource/unicorne)/keymaps/...
      local keyboard = u.current_file():match([[keyboards/(.*)/keymaps]])
      vim.cmd.FloatTerm("just choose " .. keyboard)
    end, { buf = 0 })
  end

  vim.keymap.set("n", "s<cr>", function()
    vim.cmd.FloatTerm("just run")
  end, { buf = 0 })

  vim.keymap.set("n", "m<cr>", function()
    vim.cmd.FloatTerm("just flash")
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
  vim.keymap.set("n", "d<cr>", "<cmd>Tux just debug<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { buf = 0 })
  vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { buf = 0 })

  vim.keymap.set("n", "<leader>so", "<cmd>Tux just test<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux just watch<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>st", "<cmd>Tux just watch_test<cr>", { buf = 0 })

  vim.keymap.set("n", "d<space>", function()
    local current_line = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
    local debug_cmd = ("just debug_test -o 'b %s' -o run"):format(current_line)

    tux.run(debug_cmd)
  end, { buf = 0, desc = "Test debug current line" })
else
  local cc = "clang -std=c23 -fdefer-ts -Wall -Wextra -Wpedantic -Werror -O3"
  vim.keymap.set("n", "s<cr>", "<cmd>Tux " .. cc .. " -o %:t:r %:. && ./%:t:r && rm %:t:r<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux " .. cc .. " -o %:t:r %:.<cr>", { buf = 0 })
end
