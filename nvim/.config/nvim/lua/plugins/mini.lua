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

    -- Keymaps
    vim.keymap.set("n", "_", files.open, { desc = "[mini.files] Current working directory" })
    vim.keymap.set("n", "-", function()
      files.open(vim.api.nvim_buf_get_name(0), false)
    end, { desc = "[mini.files] Current file" })

    -- Rounded borders
    local minifiles_au = vim.api.nvim_create_augroup("mini_files", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = minifiles_au,
      pattern = "MiniFilesWindowOpen",
      callback = function(args)
        vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
      end,
    })

    -- Open in split bindings
    local map_split = function(buf_id, lhs, command)
      local rhs = function()
        local fs_entry = files.get_fs_entry()
        local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"

        if not is_at_file then
          return
        end

        -- Make new window and set it as target
        local new_target_window
        local current_window = files.get_target_window()

        if not current_window then
          return
        end

        vim.api.nvim_win_call(current_window, function()
          vim.cmd(command)
          new_target_window = vim.api.nvim_get_current_win()
        end)

        files.set_target_window(new_target_window)
        files.go_in({})
        files.close()
      end

      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = command })
    end

    vim.api.nvim_create_autocmd("User", {
      group = minifiles_au,
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        map_split(buf_id, "<leader>h", "split")
        map_split(buf_id, "<leader>v", "vsplit")
        map_split(buf_id, "<leader>t", "tabnew")
      end,
    })
  end,
}
