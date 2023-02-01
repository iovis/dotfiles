return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  keys = {
    ---- align
    { mode = "n", "<leader>a,", "mzgaip,'z", remap = true },
    { mode = "x", "<leader>a,", "gai,", remap = true },

    { mode = "n", "<leader>a:", "mzgaipip:'z", remap = true },
    { mode = "x", "<leader>a:", "gaip:", remap = true },

    { mode = "n", "<leader>a=", "mzgaipi='z", remap = true },
    { mode = "x", "<leader>a=", "gai=", remap = true },
    ---- comment
    { "gcu", "mzgcgc'z", remap = true },
  },
  config = function()
    --- mini.ai (text objects)
    local ai = require("mini.ai")
    ai.setup({
      search_method = "cover_or_nearest",
      custom_textobjects = {
        -- alias 'r' to []
        r = { { "%b[]" }, "^.().*().$" },
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

    ---- mini.comment
    require("mini.comment").setup({
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    })

    ---- mini.indent (indentation guides and textobjects)
    local indent = require("mini.indentscope")
    indent.setup({
      draw = {
        delay = 0,
        animation = indent.gen_animation.none(),
      },
      symbol = "│",
    })

    local hi = require("config.highlights").hi
    local colors = require("config.highlights").colors
    hi.MiniIndentscopeSymbol = { fg = colors.gray1 }

    -- Disable in filetypes
    local indent_augroup = vim.api.nvim_create_augroup("disable_indent_guides", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = indent_augroup,
      pattern = {
        "lspsagafinder",
        "lspsagaoutline",
        "markdown",
        "sagacodeaction",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
