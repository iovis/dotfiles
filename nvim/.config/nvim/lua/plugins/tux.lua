return {
  "iovis/tux.vim",
  cmd = { "Tux", "TuxBg" },
  keys = {
    { "c<space>", ":Tux<space>" },
    { "y<space>", ":TuxBg<space>" },
    { "s<space>", ":TuxBg!<space>" },
    { "<leader>lg", ":TuxBg lazygit<cr>" },

    -- Repeat command in last tmux split
    { "<leader>i", ":Tux Up<cr>", silent = true },

    -- Execute current line
    { "<leader>I", ":silent execute 'Tux ' . escape(getline('.'), '#%')<cr>", silent = true },
    { "<leader>I", "y:silent execute 'Tux ' . escape(getreg('0'), '#%')<cr>", mode = "x", silent = true },
  },
  init = function()
    local u = require("user.utils")

    -- Docker
    u.command("Dcps", "TuxBg docker compose ps | less")
    u.command("Dcstop", "TuxBg! docker compose stop")
    u.command("Dcup", "TuxBg! docker compose up -d --remove-orphans")
  end,
}
