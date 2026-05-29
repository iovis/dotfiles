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
  vim.keymap.set("n", "s<cr>", function()
    vim.cmd.FloatTerm("just run")
  end, { buf = 0 })

  vim.keymap.set("n", "m<cr>", function()
    vim.cmd.FloatTerm("just flash")
  end, { buf = 0 })

  vim.keymap.set("n", "<leader>do", "<cmd>botright split! ../qmk_firmware/docs/keycodes.md<cr>", { buf = 0 })
  vim.keymap.set("n", "d<cr>", "<cmd>60vs keymap.md<cr>", { buf = 0 })

  vim.keymap.set("n", "s?", function()
    vim.notify(u.system({
      "qmk",
      "config",
      "user.keyboard",
    }))
  end, { buf = 0 })
else
  local cc = "clang -std=gnu23 -fdefer-ts -Wall -Wextra -Wpedantic -O3"
  vim.keymap.set("n", "s<cr>", "<cmd>Tux " .. cc .. " -o %:t:r %:. && ./%:t:r && rm %:t:r<cr>", { buf = 0 })
  vim.keymap.set("n", "m<cr>", "<cmd>Tux " .. cc .. " -o %:t:r %:.<cr>", { buf = 0 })

  vim.keymap.set("n", "d<cr>", function()
    local clang = "clang -std=gnu23 -fdefer-ts -Wall -Wextra -Wpedantic -g -O0"
    local program_name = vim.fn.expand("%:t:r")
    local file_path = vim.fn.expand("%:.")

    local compile_debug = ("%s -o %s %s"):format(clang, program_name, file_path)
    local run_debug = ('ASAN_OPTIONS=detect_leaks=0 lldb -o "b main" -o "run" -- ./%s'):format(program_name)

    tux.pane(compile_debug)
    tux.pane(run_debug, { focus = true })
  end, { buf = 0, desc = "Debug program" })
end

if u.has_justfile() then
  vim.keymap.set("n", "<leader>sd", "<cmd>Tux just compiledb<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>so", "<cmd>Tux just test<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sr", "<cmd>Tux just run_release<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>st", "<cmd>Tux just watch_test<cr>", { buf = 0 })
  vim.keymap.set("n", "<leader>sw", "<cmd>Tux just watch<cr>", { buf = 0 })

  vim.keymap.set("n", "d<cr>", function()
    tux.pane("just debug", { focus = true })
  end, { buf = 0, desc = "Tux just debug" })

  vim.keymap.set("n", "<leader>sl", function()
    local current_line = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
    local debug_cmd = ("just debug_test -o 'b %s' -o run"):format(current_line)

    tux.pane(debug_cmd, { focus = true })
  end, { buf = 0, desc = "Tux just debug_test (current line)" })
end

----Surround debug
vim.b.minisurround_config = {
  custom_surroundings = {
    e = {
      input = { "expect%(().-()%)" },
      output = { left = "expect(", right = ")" },
    },
  },
}
