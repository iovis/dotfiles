return {
  "iovis/tux.nvim",
  -- dev = true,
  event = "VeryLazy",
  config = function()
    local tux = require("tux")
    tux.setup({})

    local u = require("config.utils")
    u.ex.abbrev("tux", "Tux")

    vim.keymap.set("n", "c<space>", ":Tux<space>")
    vim.keymap.set("n", "<leader>i", "<cmd>Tux Up<cr>")
    vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>")
    vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>")
    vim.keymap.set("n", "<leader>I", ":.Tux<cr>", { desc = "[tux] execute current line" })
    vim.keymap.set("x", "<leader>i", ":Tux<cr>", { desc = "[tux] run selected lines" })

    vim.keymap.set("n", "<leader>S", function()
      if u.has_justfile() then
        tux.run("just --choose")
      else
        vim.notify("No justfile found", vim.log.levels.WARN)
      end
    end, { desc = "[tux] run a task from the Justfile" })
  end,
}
