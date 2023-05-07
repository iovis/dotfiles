return {
  "iovis/muxi.nvim",
  -- enabled = false,
  dev = true,
  event = "VeryLazy",
  keys = {},
  init = function()
    local keys = { "h", "j", "k", "l" }

    for _, key in ipairs(keys) do
      vim.keymap.set("n", "<leader>g" .. key:upper(), function()
        require("muxi").add(key)
      end, { desc = "[muxi] Add session to " .. key })

      vim.keymap.set("n", "<leader>g" .. key, function()
        require("muxi").go_to(key)
      end, { desc = "[muxi] go to session " .. key })
    end

    vim.keymap.set("n", "<leader>gs", require("muxi").go_to_prompt)
    vim.keymap.set("n", "<leader>gD", require("muxi").delete_prompt)

    vim.keymap.set("n", "<leader>g-", function()
      require("muxi").clear_all()
      vim.notify("Cleared current session")
    end)

    ---Testing-------------------------------------
    vim.keymap.set("n", "<leader>ge", function()
      vim.cmd("R! =require('muxi').sessions")
      vim.cmd("se ft=lua")
    end)

    vim.keymap.set("n", "<leader>gm", function()
      local muxi_path = require("muxi").config.path

      vim.cmd.split(muxi_path)
      vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = true })
    end)

    vim.keymap.set("n", "<leader>gr", function()
      for name, _ in pairs(package.loaded) do
        if name:match("^muxi") then
          package.loaded[name] = nil
        end
      end

      print("muxi reloaded")

      require("muxi").setup({})
    end)
  end,
  config = function()
    require("muxi").setup({})
  end,
}
