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

    vim.keymap.set("n", "<leader>ge", require("muxi.fzf").marks, { desc = "[muxi] fzf-lua marks" })

    vim.keymap.set("n", "g-", function()
      require("muxi").clear_all()
      vim.notify("Cleared current session")
    end, { desc = "[muxi] Clear current workspace" })

    vim.keymap.set("n", "yom", function()
      local muxi = require("muxi")
      muxi.config.save_cursor = not muxi.config.save_cursor
    end, { desc = "[muxi] Toggle go to cursor" })

    ---Testing-------------------------------------
    -- vim.keymap.set("n", "<leader>gs", require("muxi.ui").go_to_prompt, { desc = "[muxi] Interactive go to" })
    -- vim.keymap.set("n", "<leader>gd", require("muxi.ui").delete_prompt, { desc = "[muxi] Interactive delete" })

    vim.keymap.set("n", "ge", function()
      -- Turn muxi marks into a pretty array of strings
      local marks = require("muxi").marks
      local marks_table = vim.split(vim.inspect(marks), "\n")

      -- Make a popup window
      local bufnr = vim.api.nvim_create_buf(false, true)
      local half_screen_width = math.floor(vim.o.columns / 2)
      local half_screen_height = math.floor(vim.o.lines / 2)
      local width = half_screen_width
      local height = math.max(math.min(half_screen_height, #marks_table), 10)

      vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        width = width,
        height = height,
        row = 10,
        col = half_screen_width - math.floor(width / 2) - 6,
        style = "minimal",
        border = "rounded",
        title = " muxi ",
        noautocmd = true,
      })

      -- Set the contents to muxi table and the filetype to lua
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, marks_table)
      vim.api.nvim_buf_set_option(bufnr, "filetype", "lua")

      -- Save new marks when leaving the popup
      local augroup_muxi = vim.api.nvim_create_augroup("muxi_marks", { clear = true })
      vim.api.nvim_create_autocmd("BufLeave", {
        desc = "Save muxi table",
        group = augroup_muxi,
        buffer = bufnr,
        callback = function()
          -- Poor man's eval
          local new_marks_string = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
          local new_marks = load(table.concat({ "return", new_marks_string }, " "))()

          require("muxi"):sync(function(muxi)
            muxi.marks = new_marks
          end)

          vim.notify("muxi updated")
        end,
      })

      -- Map [q] to read the changes and close the popup
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = bufnr })
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
