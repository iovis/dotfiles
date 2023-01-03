return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  keys = {
    ---- Quick Align
    { mode = "n", "<leader>a,", "mzgaip,'z", remap = true },
    { mode = "x", "<leader>a,", "gai,", remap = true },

    { mode = "n", "<leader>a:", "mzgaipip:'z", remap = true },
    { mode = "x", "<leader>a:", "gaip:", remap = true },

    { mode = "n", "<leader>a=", "mzgaipi='z", remap = true },
    { mode = "x", "<leader>a=", "gai=", remap = true },
  },
  config = function()
    local u = require("user.utils")

    --- mini.ai (text objects)
    local ai = require("mini.ai")
    ai.setup({
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

    ---- mini.indent (indentation guides and textobjects)
    local indent = require("mini.indentscope")
    indent.setup({
      draw = {
        delay = 0,
        animation = indent.gen_animation.none(),
      },
      symbol = "│",
    })

    u.highlight("MiniIndentscopeSymbol", { fg = "#333333" })
  end,
}
