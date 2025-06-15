return {
  "folke/snacks.nvim",
  config = function()
    local snacks = require("snacks")

    snacks.setup({
      picker = {
        sources = {
          filetypes = {
            name = "filetypes",
            format = "text",
            preview = "none",
            layout = { preset = "vscode" },
            confirm = function(picker, item)
              picker:close()
              if item then
                vim.schedule(function()
                  vim.cmd("setfiletype " .. item.text)
                end)
              end
            end,
            finder = function()
              local items = {}
              local filetypes = vim.fn.getcompletion("", "filetype")
              for _, type in ipairs(filetypes) do
                items[#items + 1] = {
                  text = type,
                }
              end
              return items
            end,
          },
        },
        win = {
          input = {
            keys = {
              ["<F2>"] = { "toggle_maximize", mode = { "i", "n" } },
              ["<c-a>"] = "",
              ["<c-u>"] = "list_scroll_up",
              ["<esc>"] = { "close", mode = { "n", "i" } },
              ["<m-a>"] = { "select_all", mode = { "n", "i" } },
              ["<m-cr>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
              ["<m-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<m-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<m-q>"] = { "qflist", mode = { "i", "n" } },
            },
          },
        },
      },
    })

    vim.keymap.set("n", "s<space>", function()
      snacks.picker()
    end, { desc = "snacks.picker" })

    vim.keymap.set("n", "<leader>R", snacks.picker.registers, { desc = "snacks.picker.registers" })
    vim.keymap.set("n", "<leader>f/", snacks.picker.lines, { desc = "snacks.picker.lines" })
    vim.keymap.set("n", "<leader>fh", snacks.picker.help, { desc = "snacks.picker.help" })
    vim.keymap.set("n", "<leader>fm", snacks.picker.man, { desc = "snacks.picker.man" })
    vim.keymap.set("n", "<leader>fq", snacks.picker.qflist, { desc = "snacks.picker.qflist" })
    vim.keymap.set("n", "<leader>j", snacks.picker.git_status, { desc = "snacks.picker.git_status" })
    vim.keymap.set("n", "<leader>r", snacks.picker.resume, { desc = "snacks.picker.resume" })
    vim.keymap.set("n", "U", snacks.picker.undo, { desc = "snacks.picker.undo" })
    vim.keymap.set("n", "gm", snacks.picker.buffers, { desc = "snacks.picker.buffers" })

    ---@diagnostic disable-next-line: undefined-field
    vim.keymap.set("n", "<leader>F", snacks.picker.filetypes, { desc = "snacks.picker.filetypes" })

    -- Files
    vim.keymap.set("n", "<leader>o", function()
      snacks.picker.files({ hidden = true })
    end, { desc = "Find Files" })

    vim.keymap.set("n", "<leader>ud", function()
      snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Open Neovim config" })

    -- Grep
    vim.keymap.set({ "n", "x" }, "<leader>fl", function()
      snacks.picker.grep_word({ hidden = true })
    end, { desc = "snacks.picker.grep_word" })

    vim.keymap.set("n", "<leader>fk", function()
      snacks.picker.grep({
        search = "\\w",
        live = false,
        hidden = true,
      })
    end, { desc = "snacks.picker.grep" })

    vim.keymap.set("n", "<leader>fg", function()
      snacks.picker.grep({ hidden = true })
    end, { desc = "snacks.picker.grep" })

    -- LSP
    vim.keymap.set("n", "<leader>ls", snacks.picker.lsp_symbols, { desc = "snacks.picker.lsp_symbols" })
    vim.keymap.set(
      "n",
      "<leader>lw",
      snacks.picker.lsp_workspace_symbols,
      { desc = "snacks.picker.lsp_workspace_symbols" }
    )
    vim.keymap.set(
      "n",
      "<leader>lw",
      snacks.picker.lsp_workspace_symbols,
      { desc = "snacks.picker.lsp_workspace_symbols" }
    )
    vim.keymap.set("n", "<leader>ld", snacks.picker.diagnostics, { desc = "snacks.picker.diagnostics" })

    -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  end,
}
