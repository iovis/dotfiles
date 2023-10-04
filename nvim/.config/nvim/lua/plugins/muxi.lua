return {
  "iovis/muxi.nvim",
  -- enabled = false,
  -- dev = true,
  event = "VeryLazy",
  config = function()
    ----Setup
    require("muxi").setup({
      go_to_cursor = false,
      path = ".muxi.json",
    })

    ----Muxi superbinding
    vim.keymap.set("n", "<leader>g", require("muxi.ui").superbinding, {
      desc = "[muxi] Mark/go to file",
    })

    vim.keymap.set("n", "m", function()
      require("muxi.ui").superbinding({ go_to_cursor = true })
    end, {
      desc = "[muxi] Mark/go to file (cursor: true)",
    })

    ----Arbitrary mapping
    vim.keymap.set("n", "m<space>", require("muxi.ui").add, {
      desc = "[muxi] Add arbitrary key",
    })

    ----Quick maps
    local keys = { "h", "j", "k", "l", "ñ" }

    for _, key in ipairs(keys) do
      vim.keymap.set("n", "g" .. key:upper(), function()
        require("muxi").add(key)
        vim.notify("Added current file to " .. key)
      end, { desc = "[muxi] Add session to " .. key })

      vim.keymap.set("n", "g" .. key, function()
        require("muxi").go_to(key, { go_to_cursor = false })
      end, { desc = "[muxi] go to session " .. key })
    end

    -- ñ:upper() doesn't work great
    vim.keymap.set("n", "gÑ", function()
      require("muxi").add("ñ")
      vim.notify("Added current file to ñ")
    end, { desc = "[muxi] Add session to ñ" })

    ----Mark management
    vim.keymap.set("n", "g-", require("muxi.fzf").marks, {
      desc = "[muxi] fzf-lua marks",
    })

    vim.keymap.set("n", "m?", require("muxi.fzf").sessions, {
      desc = "[muxi] fzf-lua sessions",
    })

    vim.keymap.set("n", "m!", function()
      require("muxi").clear_all()
      vim.notify("Cleared current session")
    end, { desc = "[muxi] Clear current workspace" })

    vim.keymap.set("n", "ge", require("muxi.ui").show, {
      desc = "[muxi] Modify current workspace interactively",
    })

    ----Settings toggles
    vim.keymap.set("n", "yom", function()
      local muxi = require("muxi")

      muxi.config.go_to_cursor = not muxi.config.go_to_cursor

      local message = "Muxi go to cursor "
      message = message .. (muxi.config.go_to_cursor and "enabled" or "disabled")
      vim.notify(message)
    end, { desc = "[muxi] Toggle go to cursor" })

    ---Testing-------------------------------------
    -- vim.keymap.set("n", "<leader>gs", require("muxi.ui").go_to_prompt, { desc = "[muxi] Interactive go to" })
    -- vim.keymap.set("n", "<leader>gd", require("muxi.ui").delete_prompt, { desc = "[muxi] Interactive delete" })
    --
    -- vim.keymap.set("n", "<leader>gM", function()
    --   local muxi_path = require("muxi").config.path
    --   vim.cmd.split(muxi_path)
    --   vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
    -- end, { desc = "[muxi] Open storage" })
  end,
}
