return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      signs = {
        delete = { show_count = true },
        topdelete = { show_count = true },
      },
      current_line_blame_opts = { delay = 100 },
      on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "yoq", gitsigns.toggle_current_line_blame, { desc = "[gitsigns] Toggle current line blame" })
        map("n", "<leader>ds", gitsigns.preview_hunk, { desc = "[gitsigns] Preview hunk" })
        map("n", "<leader>dk", gitsigns.reset_hunk, { desc = "[gitsigns] Reset hunk" })
        map("x", "<leader>dk", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "[gitsigns] reset lines" })
        map("n", "'c", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "[gitsigns] show commit details for current line" })

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)
      end,
    })
  end,
}
