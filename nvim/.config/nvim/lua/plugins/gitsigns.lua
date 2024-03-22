return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {
    current_line_blame_opts = {
      delay = 100,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      map("n", "yob", gs.toggle_current_line_blame, { desc = "[gitsigns] Toggle current line blame" })
      map("n", "<leader>ds", gs.preview_hunk, { desc = "[gitsigns] Preview hunk" })
      map("n", "<leader>dk", gs.reset_hunk, { desc = "[gitsigns] Reset hunk" })
      map("x", "<leader>dk", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("n", "+h", function()
        gs.blame_line({ full = true })
      end)
      map({ "o", "x" }, "ik", ":<C-U>Gitsigns select_hunk<CR>")

      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end

        vim.schedule(function()
          gs.next_hunk()
        end)

        return "<Ignore>"
      end, { expr = true, desc = "next hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end

        vim.schedule(function()
          gs.prev_hunk()
        end)

        return "<Ignore>"
      end, { expr = true, desc = "previous hunk" })
    end,
  },
}
