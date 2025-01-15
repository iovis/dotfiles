return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1

    --- Terminal mode mappings
    local mappings = {
      { key = "<c-h>", cmd = "TmuxNavigateLeft" },
      { key = "<c-j>", cmd = "TmuxNavigateDown" },
      { key = "<c-k>", cmd = "TmuxNavigateUp" },
      { key = "<c-l>", cmd = "TmuxNavigateRight" },
    }

    for _, map in ipairs(mappings) do
      vim.keymap.set("t", map.key, function()
        local u = require("config.utils")

        if u.is_win_floating() then
          -- send key if floating
          local key = vim.api.nvim_replace_termcodes(map.key, true, false, true)
          vim.api.nvim_feedkeys(key, "n", false)
        else
          -- navigate to pane
          vim.cmd[map.cmd]()
        end
      end)
    end
  end,
}
