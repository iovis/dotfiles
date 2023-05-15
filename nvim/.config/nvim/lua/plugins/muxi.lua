return {
  "iovis/muxi.nvim",
  -- enabled = false,
  dev = true,
  event = "VeryLazy",
  config = function()
    require("muxi").setup({
      save_cursor = false,
    })

    local keys = { "h", "j", "k", "l", "ñ" }

    for _, key in ipairs(keys) do
      vim.keymap.set("n", "g" .. key:upper(), function()
        require("muxi").add(key)
        vim.notify("Added current file to " .. key)
      end, { desc = "[muxi] Add session to " .. key })

      vim.keymap.set("n", "g" .. key, function()
        require("muxi").go_to(key)
      end, { desc = "[muxi] go to session " .. key })
    end

    -- ñ:upper() doesn't work great
    vim.keymap.set("n", "gÑ", function()
      require("muxi").add("ñ")
      vim.notify("Added current file to ñ")
    end, { desc = "[muxi] Add session to ñ" })

    vim.keymap.set("n", "ge", require("muxi.fzf").marks, { desc = "[muxi] fzf-lua marks" })

    vim.keymap.set("n", "g-", function()
      require("muxi").clear_all()
      vim.notify("Cleared current session")
    end, { desc = "[muxi] Clear current workspace" })

    ---Testing-------------------------------------
    -- vim.keymap.set("n", "<leader>gs", require("muxi.ui").go_to_prompt, { desc = "[muxi] Interactive go to" })
    -- vim.keymap.set("n", "<leader>gd", require("muxi.ui").delete_prompt, { desc = "[muxi] Interactive delete" })

    vim.keymap.set("n", "<leader>ge", function()
      vim.cmd("R! =require('muxi').marks")
      vim.cmd("se ft=lua")

      vim.keymap.set("n", "q", function()
        -- Poor man's eval
        local new_marks_string = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
        local new_marks = loadstring(table.concat({ "return", new_marks_string }, " "))()

        require("muxi"):sync(function(muxi)
          muxi.marks = new_marks
        end)

        vim.cmd.close()
        vim.notify("muxi updated")
      end, { buffer = true, desc = "Update muxi marks and close" })
    end, { desc = "[muxi] Modify current workspace interactively" })

    vim.keymap.set("n", "<leader>gm", function()
      local muxi_path = require("muxi").config.path

      vim.cmd.split(muxi_path)
      vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
    end, { desc = "[muxi] Open storage" })

    vim.keymap.set("n", "<leader>gr", function()
      for name, _ in pairs(package.loaded) do
        if name:match("^muxi") then
          package.loaded[name] = nil
        end
      end

      print("muxi reloaded")

      require("muxi").setup({})
    end, { desc = "[muxi] Reload muxi" })
  end,
}
