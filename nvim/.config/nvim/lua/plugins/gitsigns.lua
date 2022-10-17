require("gitsigns").setup({
  current_line_blame_opts = {
    delay = 100,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function nmap(lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set("n", lhs, rhs, opts)
    end

    nmap("+q", gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })

    nmap("]c", function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function()
        gs.next_hunk()
      end)

      return "<Ignore>"
    end, { expr = true, desc = "next hunk" })

    nmap("[c", function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function()
        gs.prev_hunk()
      end)

      return "<Ignore>"
    end, { expr = true, desc = "previous hunk" })
  end,
})