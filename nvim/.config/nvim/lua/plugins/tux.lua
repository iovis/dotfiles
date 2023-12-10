return {
  "iovis/tux.nvim",
  dev = true,
  event = "VeryLazy",
  keys = {
    { "c<space>", ":Tux<space>" },
    { "s<space>", ":Tuxw<space>" },

    -- Repeat command in last tmux split
    { "<leader>i", ":Tux Up<cr>", silent = true },

    -- Just
    { "S", "<cmd>Tux jf<cr>", desc = "Run a task from the Justfile" },
    { "s<cr>", "<cmd>Tux just run<cr>", desc = "just run" },
    { "m<cr>", "<cmd>Tux just build<cr>", desc = "just build" },

    -- Execute current line
    { "<leader>I", ":silent execute 'Tux ' . escape(getline('.'), '#%')<cr>", silent = true },
    { "<leader>I", "y:silent execute 'Tux ' . escape(getreg('0'), '#%')<cr>", mode = "x", silent = true },
  },
  config = function()
    local tux = require("tux")
    tux.setup({})
  end,
}
