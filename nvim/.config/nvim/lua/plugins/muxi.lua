return {
  "iovis/muxi.nvim",
  -- enabled = false,
  dev = true,
  event = "VeryLazy",
  keys = {},
  init = function()
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

    vim.keymap.set("n", "<leader>gs", require("muxi").go_to_prompt, { desc = "[muxi] Interactive go to" })
    vim.keymap.set("n", "<leader>gd", require("muxi").delete_prompt, { desc = "[muxi] Interactive delete" })

    vim.keymap.set("n", "<leader>g-", function()
      require("muxi").clear_all()
      vim.notify("Cleared current session")
    end, { desc = "[muxi] Clear current workspace" })

    ---Testing-------------------------------------
    vim.keymap.set("n", "<leader>ge", function()
      vim.cmd("R! =require('muxi').sessions")
      vim.cmd("se ft=lua")
    end, { desc = "[muxi] Inspect current workspace" })

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
  config = function()
    require("muxi").setup({})
  end,
}
