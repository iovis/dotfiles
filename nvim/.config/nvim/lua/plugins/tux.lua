return {
  "iovis/tux.vim",
  event = "VeryLazy",
  keys = {
    { "c<space>", ":Tux<space>" },
    { "y<space>", ":TuxBg<space>" },
    { "s<space>", ":TuxBg!<space>" },

    -- Repeat command in last tmux split
    { "<leader>i", ":Tux Up<cr>", silent = true },

    -- Execute current line
    { "<leader>I", ":silent execute 'Tux ' . escape(getline('.'), '#%')<cr>", silent = true },
    { "<leader>I", "y:silent execute 'Tux ' . escape(getreg('0'), '#%')<cr>", mode = "x", silent = true },
  },
  init = function()
    local u = require("config.utils")

    ----Just
    vim.keymap.set("n", "S", "<cmd>Tux jf<cr>", { desc = "Run a task from the Justfile" })
    vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { desc = "just run" })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { desc = "just build" })

    ----Docker
    u.command("Dcps", "TuxBg dcps")
    u.command("Dcstop", "TuxBg! dcstop")
    u.command("Dcup", "TuxBg! dcup")
  end,
}
