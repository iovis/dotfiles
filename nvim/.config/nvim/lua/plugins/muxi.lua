return {
  "iovis/muxi.nvim",
  -- enabled = false,
  -- dev = true,
  event = "VeryLazy",
  config = function()
    ----Setup
    local muxi = require("muxi")

    muxi.setup({
      go_to_cursor = false,
      -- path = ".muxi.json",
    })

    ----Bindings
    vim.keymap.set("n", "<leader>g", muxi.ui.run, {
      desc = "[muxi] Mark/go to file",
    })

    vim.keymap.set("n", "m", function()
      muxi.ui.run({ go_to_cursor = true })
    end, {
      desc = "[muxi] Mark/go to file (cursor: true)",
    })

    vim.keymap.set("n", "dm", muxi.ui.quick_delete, {
      desc = "[muxi] Delete mark",
    })

    vim.keymap.set("n", "m<space>", ":Muxi add<space>")
    vim.keymap.set("n", "dm<space>", ":Muxi delete<space>")

    ----Quick maps
    local keys = { "h", "j", "k", "l" }

    for _, key in ipairs(keys) do
      vim.keymap.set("n", "g" .. key:upper(), function()
        muxi.add(key)
        vim.notify("Added current file to " .. key)
      end, { desc = "[muxi] Add session to " .. key })

      vim.keymap.set("n", "g" .. key, function()
        muxi.go_to(key, { go_to_cursor = false })
      end, { desc = "[muxi] go to session " .. key })
    end

    vim.keymap.set("n", "g;", function()
      muxi.go_to(";", { go_to_cursor = false })
    end, { desc = "[muxi] go to session ;" })

    vim.keymap.set("n", "g:", function()
      muxi.add(";")
      vim.notify("Added current file to ;")
    end, { desc = "[muxi] Add session to ;" })

    ----Mark management
    vim.keymap.set("n", "g/", muxi.fzf.marks, {
      desc = "[muxi] fzf-lua marks",
    })

    vim.keymap.set("n", "m?", muxi.fzf.sessions, {
      desc = "[muxi] fzf-lua sessions",
    })

    vim.keymap.set("n", "m!", function()
      muxi.clear_all()
      vim.notify("Cleared current session")
    end, { desc = "[muxi] Clear current workspace" })

    vim.keymap.set("n", "ge", muxi.ui.edit, {
      desc = "[muxi] Modify current workspace interactively",
    })

    -- ----Settings toggles
    -- vim.keymap.set("n", "yom", function()
    --   muxi.config.go_to_cursor = not muxi.config.go_to_cursor
    --
    --   local message = "Muxi go to cursor "
    --   message = message .. (muxi.config.go_to_cursor and "enabled" or "disabled")
    --   vim.notify(message)
    -- end, { desc = "[muxi] Toggle go to cursor" })

    ---Testing-------------------------------------
    -- vim.keymap.set("n", "<leader>gs", muxi.ui.go_to_prompt, { desc = "[muxi] Interactive go to" })
    -- vim.keymap.set("n", "<leader>gd", muxi.ui.delete_prompt, { desc = "[muxi] Interactive delete" })
    --
    -- vim.keymap.set("n", "<leader>gM", function()
    --   local muxi_path = muxi.config.path
    --   vim.cmd.split(muxi_path)
    --   vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
    -- end, { desc = "[muxi] Open storage" })
  end,
}
