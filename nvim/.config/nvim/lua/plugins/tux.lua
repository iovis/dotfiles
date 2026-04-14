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
    vim.keymap.set("n", "<leader>i", ":Tux Up<cr>", {
      desc = "[tux] repeat last tmux command",
      silent = true,
    })

    local function run_justfile_task_picker()
      if u.has_justfile() then
        tux.run("just --choose")
      else
        vim.notify("No justfile found", vim.log.levels.WARN)
      end
    end

    vim.keymap.set("n", "s<cr>", "<cmd>Tux just run<cr>", { desc = "[tux] just run" })
    vim.keymap.set("n", "m<cr>", "<cmd>Tux just build<cr>", { desc = "[tux] just build" })
    vim.keymap.set("n", "<leader>S", run_justfile_task_picker, { desc = "[tux] run a task from the Justfile" })
    vim.keymap.set("n", "<leader>I", ":.Tux<cr>", { desc = "[tux] execute current line" })
    vim.keymap.set("x", "<leader>i", ":Tux<cr>", { desc = "[tux] run selected lines" })
  end,
}
