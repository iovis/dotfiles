return {
  "iovis/tux.nvim",
  -- dev = true,
  config = function()
    local tux = require("tux")

    tux.setup({})

    local u = require("config.utils")
    u.ex.abbrev("tux", "Tux")

    vim.keymap.set("n", "c<space>", ":Tux<space>")
    vim.keymap.set("n", "<leader>i", "<cmd>Tux Up<cr>")
    vim.keymap.set("n", "<leader>I", ":.Tux<cr>", { desc = "[tux] execute current line" })
    vim.keymap.set("x", "<leader>i", ":Tux<cr>", { desc = "[tux] run selected lines" })

    vim.keymap.set("n", "<m-p>", function()
      tux.send_file({ prefix = "" })
    end, { desc = "[tux] send current file" })

    vim.keymap.set({ "n", "x" }, "<m-n>", function()
      tux.send_location({ prefix = "" })
    end, { desc = "[tux] send current file location" })

    if u.has_justfile() then
      vim.keymap.set("n", "<leader>st", "<cmd>Tux just test<cr>")

      vim.keymap.set("n", "<leader>sk", "<cmd>Tux just run<cr>")
      vim.keymap.set("n", "<leader>sm", "<cmd>Tux just build<cr>")

      vim.keymap.set("n", "<leader>sl", function()
        tux.pane("just console", { focus = true })
      end, { desc = "Tux just console" })
    end
  end,
}
