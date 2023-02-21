return {
  "echasnovski/mini.nvim",
  -- enabled = false,
  event = "VeryLazy",
  keys = {
    ---- align
    { mode = "n", "<leader>a,", "mzgaip,'z", remap = true },
    { mode = "x", "<leader>a,", "gai,", remap = true },

    { mode = "n", "<leader>a:", "mzgaipip:'z", remap = true },
    { mode = "x", "<leader>a:", "gaip:", remap = true },

    { mode = "n", "<leader>a=", "mzgaipi='z", remap = true },
    { mode = "x", "<leader>a=", "gai=", remap = true },
  },
  config = function()
    --- mini.ai (text objects)
    local ai = require("mini.ai")
    ai.setup({
      search_method = "cover_or_nearest",
      custom_textobjects = {
        -- NOTES:
        --   - %b(xy) => delimited pair  %b[], %b{}
        --   - %f[x]  => frontier  %f[%w]
        --   - ()x()x()x() => define limits of 'a' and 'i'
        --       - a: xxx
        --       - i:  x

        -- alias 'r' to []
        r = { "%b[]", "^.().*().$" },
        -- Number
        n = { "%f[%d]%d+" },
        -- Line
        l = { "^()%s*().*()().$" },
        -- Entire buffer
        e = function(ai_type)
          local n_lines = vim.fn.line("$")
          local start_line, end_line = 1, n_lines

          if ai_type == "i" then
            -- Skip first and last blank lines for `i` textobject
            local first_nonblank, last_nonblank = vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
            start_line = first_nonblank == 0 and 1 or first_nonblank
            end_line = last_nonblank == 0 and n_lines or last_nonblank
          end

          local to_col = math.max(vim.fn.getline(end_line):len(), 1)

          return {
            from = { line = start_line, col = 1 },
            to = { line = end_line, col = to_col },
          }
        end,
      },
      mappings = {
        -- Next/last textobjects
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "",
        goto_right = "",
      },
    })

    ---- mini.align
    require("mini.align").setup({})

    ---- mini.bufremove (remove buffer without messing windows)
    local bufrm = require("mini.bufremove")
    bufrm.setup({})

    vim.keymap.set("n", "º", bufrm.delete, { desc = "Bdelete" })
    vim.keymap.set("n", "ª", function()
      bufrm.delete(0, true)
    end, { desc = "Bdelete!" })

    ---- mini.indent (indentation guides and textobjects)
    local indent = require("mini.indentscope")
    indent.setup({
      draw = {
        delay = 0,
        animation = indent.gen_animation.none(),
      },
      symbol = "│",
    })

    -- Disable in filetypes
    local indent_augroup = vim.api.nvim_create_augroup("disable_indent_guides", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = indent_augroup,
      pattern = {
        "fzf",
        "help",
        "lazy",
        "lspsagafinder",
        "lspsagaoutline",
        "markdown",
        "mason",
        "noice",
        "notify",
        "sagacodeaction",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
