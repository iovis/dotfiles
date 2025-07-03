return {
  "iovis/muxi.nvim",
  -- enabled = false,
  -- dev = true,
  event = "VeryLazy",
  config = function()
    ----Setup
    local muxi = require("muxi")

    muxi.setup({})

    ----Bindings
    vim.keymap.set("n", "<leader>g", muxi.ui.run, {
      desc = "[muxi] Mark/go to file",
    })

    vim.keymap.set({ "n", "x" }, "m", function()
      muxi.ui.run({ go_to_cursor = true })
    end, {
      desc = "[muxi] Mark/go to file (cursor: true)",
    })

    vim.keymap.set("n", "'m", "m", { desc = "Original mark" })
    vim.keymap.set("n", "''", "'", { desc = "Original go to mark" })

    vim.keymap.set("n", "dm", muxi.ui.quick_delete, {
      desc = "[muxi] Delete mark",
    })

    vim.keymap.set("n", "dm<space>", ":Muxi delete<space>")
    vim.keymap.set("n", "m<space>", function()
      vim.ui.input({ prompt = "key" }, function(input)
        local key = vim.trim(input or "")
        muxi.add(key)
      end)
    end)

    ----Quick maps
    for lower, upper in pairs({
      h = "H",
      j = "J",
      k = "K",
      l = "L",
    }) do
      vim.keymap.set("n", "g" .. upper, function()
        muxi.add(lower)
        vim.notify("Added current file to " .. lower)
      end, { desc = "[muxi] Add file to " .. lower })

      vim.keymap.set("n", "g" .. lower, function()
        muxi.go_to(lower, { go_to_cursor = false })
      end, { desc = "[muxi] go to file " .. lower })
    end

    ----Mark management
    vim.keymap.set("n", "g/", function()
      ---@diagnostic disable-next-line: undefined-field
      Snacks.picker.muxi_marks()
    end, { desc = "snacks.picker.muxi_marks" })

    vim.keymap.set("n", "m/", muxi.ui.qf, {
      desc = "[muxi] quickfix marks",
    })

    -- vim.keymap.set("n", "m?", muxi.fzf.sessions, {
    --   desc = "[muxi] fzf-lua sessions",
    -- })

    vim.keymap.set("n", "m!", function()
      muxi.clear_all()
      vim.notify("Cleared current marks")
    end, { desc = "[muxi] Clear current workspace" })

    vim.keymap.set("n", "'e", muxi.ui.edit, {
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
