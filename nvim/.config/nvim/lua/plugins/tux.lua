return {
  "iovis/tux.nvim",
  -- dev = true,
  event = "VeryLazy",
  keys = {
    { "c<space>", ":Tux<space>" },
    { "s<space>", ":Tuxw<space>" },
    { "y<space>", ":Tuxpop<space>" },

    -- Repeat command in last tmux split
    { "<leader>i", ":Tux Up<cr>", silent = true },

    -- Just
    { "s<cr>", "<cmd>Tux just run<cr>", desc = "just run" },
    { "m<cr>", "<cmd>Tux just build<cr>", desc = "just build" },

    -- Execute current line
    { "<leader>I", ":silent execute 'Tux ' . escape(getline('.'), '#%')<cr>", silent = true },
    { "<leader>I", "y:silent execute 'Tux ' . escape(getreg('0'), '#%')<cr>", mode = "x", silent = true },
  },
  config = function()
    local tux = require("tux")

    tux.setup({
      popup = {
        auto_close = "success",
        width = "80%",
        height = "80%",
      },
    })

    local u = require("config.utils")
    vim.keymap.set("n", "<leader>S", function()
      if u.has_justfile() then
        tux.run("jf")
      else
        vim.notify("No justfile found", vim.log.levels.WARN)
      end
    end, { desc = "Run a task from the Justfile" })
  end,
}
