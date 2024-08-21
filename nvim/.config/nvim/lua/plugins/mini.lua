return {
  "echasnovski/mini.nvim",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    --- mini.ai (text objects)
    local ai = require("mini.ai")
    local gen_ai_spec = require("mini.extra").gen_ai_spec
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
        n = gen_ai_spec.number(),
        l = gen_ai_spec.line(),
        i = gen_ai_spec.indent(),
        e = gen_ai_spec.buffer(),
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

    vim.keymap.set("n", "<leader>a,", "mzgaipi,'z", { remap = true })
    vim.keymap.set("x", "<leader>a,", "gai,", { remap = true })

    vim.keymap.set("n", "<leader>a:", "mzgaipip:'z", { remap = true })
    vim.keymap.set("x", "<leader>a:", "gaip:", { remap = true })

    vim.keymap.set("n", "<leader>a=", "mzgaipi='z", { remap = true })
    vim.keymap.set("x", "<leader>a=", "gai=", { remap = true })

    ---- mini.bufremove (remove buffer without messing windows)
    local bufremove = require("mini.bufremove")
    bufremove.setup({})

    vim.keymap.set("n", "<leader>B", function()
      bufremove.delete(0, true)
    end, { desc = "Bdelete!" })
  end,
}
