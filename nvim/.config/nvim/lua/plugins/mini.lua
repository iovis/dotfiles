return {
  "echasnovski/mini.nvim",
  -- enabled = false,
  event = "VeryLazy",
  keys = {
    ----align
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

    ---- mini.bufremove (remove buffer without messing windows)
    local bufremove = require("mini.bufremove")
    bufremove.setup({})

    vim.keymap.set("n", "º", bufremove.delete, { desc = "Bdelete" })
    vim.keymap.set("n", "ª", function()
      bufremove.delete(0, true)
    end, { desc = "Bdelete!" })

    ---- mini.indent (indentation guides and textobjects)
    -- local indent = require("mini.indentscope")
    -- indent.setup({
    --   draw = {
    --     delay = 0,
    --     animation = indent.gen_animation.none(),
    --   },
    --   options = {
    --     try_as_border = true,
    --   },
    --   symbol = "│",
    -- })
    --
    -- -- Disable in filetypes
    -- local indent_augroup = vim.api.nvim_create_augroup("disable_indent_guides", { clear = true })
    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = indent_augroup,
    --   pattern = {
    --     "fzf",
    --     "help",
    --     "lazy",
    --     "lspsagafinder",
    --     "lspsagaoutline",
    --     "markdown",
    --     "mason",
    --     "noice",
    --     "notify",
    --     "oil",
    --     "oil_preview",
    --     "sagacodeaction",
    --   },
    --   callback = function()
    --     vim.b.miniindentscope_disable = true
    --   end,
    -- })

    ---- mini.files
    local files = require("mini.files")
    files.setup({
      options = {
        use_as_default_explorer = false,
      },

      mappings = {
        close = "q",
        go_in = "",
        go_in_plus = "<cr>",
        go_out = "",
        go_out_plus = "-",
        reset = "<bs>",
        reveal_cwd = "_",
        show_help = "g?",
        synchronize = "<leader>w",
        trim_left = "<",
        trim_right = ">",
      },
    })

    vim.keymap.set("n", "_", files.open, { desc = "[mini.files] Current working directory" })
    vim.keymap.set("n", "-", function()
      files.open(vim.api.nvim_buf_get_name(0), false)
    end, { desc = "[mini.files] Current file" })
  end,
}
