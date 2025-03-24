return {
  "echasnovski/mini.nvim",
  -- enabled = false,
  version = "*",
  event = "VeryLazy",
  config = function()
    ---- mini.ai (text objects)
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

    vim.keymap.set("n", "<tab>", function()
      bufremove.delete(0, false)
    end, { desc = "Bdelete" })

    vim.keymap.set("n", "<s-tab>", function()
      bufremove.delete(0, false)
    end, { desc = "Bdelete!" })

    ---- mini.files
    -- require("mini.files").setup({
    --   mappings = {
    --     close = "q",
    --     go_in = "",
    --     go_in_plus = "<cr>",
    --     go_out = "",
    --     go_out_plus = "_",
    --     reset = "<bs>",
    --     reveal_cwd = "@",
    --     show_help = "g?",
    --     synchronize = "<leader>w",
    --   },
    --   windows = {
    --     width_preview = 50,
    --   },
    -- })
    --
    -- --- Toggle explorer
    -- vim.keymap.set("n", "_", function()
    --   if not MiniFiles.close() then
    --     MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    --   end
    -- end)
    --
    -- --- Toggle dotfiles
    -- local show_dotfiles = true
    -- local function filter_show(_fs_entry)
    --   return true
    -- end
    --
    -- local function filter_hide(fs_entry)
    --   return not vim.startswith(fs_entry.name, ".")
    -- end
    --
    -- local function toggle_dotfiles()
    --   show_dotfiles = not show_dotfiles
    --   local new_filter = show_dotfiles and filter_show or filter_hide
    --
    --   MiniFiles.refresh({
    --     content = {
    --       filter = new_filter,
    --     },
    --   })
    -- end
    --
    -- --- Toggle preview
    -- local show_preview = false
    -- local function toggle_preview()
    --   show_preview = not show_preview
    --
    --   MiniFiles.refresh({
    --     windows = {
    --       preview = show_preview,
    --       width_preview = 50,
    --     },
    --   })
    -- end
    --
    -- --- Open in split
    -- local map_split = function(buf_id, lhs, direction)
    --   local rhs = function()
    --     -- Make new window and set it as target
    --     local cur_target = MiniFiles.get_explorer_state().target_window
    --     local new_target = vim.api.nvim_win_call(cur_target, function()
    --       vim.cmd(direction .. " split")
    --       return vim.api.nvim_get_current_win()
    --     end)
    --
    --     MiniFiles.set_target_window(new_target)
    --     MiniFiles.go_in({ close_on_file = true })
    --   end
    --
    --   vim.keymap.set("n", lhs, rhs, {
    --     buffer = buf_id,
    --     desc = "Split " .. direction,
    --   })
    -- end
    --
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "MiniFilesBufferCreate",
    --   callback = function(args)
    --     local buf_id = args.data.buf_id
    --
    --     vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
    --     vim.keymap.set("n", "<M-p>", toggle_preview, { buffer = buf_id })
    --
    --     map_split(buf_id, "<leader>h", "belowright horizontal")
    --     map_split(buf_id, "<leader>v", "belowright vertical")
    --   end,
    -- })

    ---- mini.operators
    local operators = require("mini.operators")

    operators.setup({
      evaluate = { prefix = "g=" },
      exchange = { prefix = "ge" }, -- Default `gx`
      multiply = { prefix = "g." }, -- Default `gm`
      replace = { prefix = "gr" },
      sort = { prefix = "gs" },
    })

    vim.keymap.set("x", "D", "g.", { remap = true })

    vim.keymap.set("n", "R", "'m`griw``", { remap = true })
    vim.keymap.set("x", "R", "gr", { remap = true })

    vim.keymap.set("n", "S", "'m`geiw``", { remap = true })
    vim.keymap.set("x", "S", "ge", { remap = true })

    ---- mini.surround
    require("mini.surround").setup({
      search_method = "cover_or_nearest",
      custom_surroundings = {
        r = {
          input = { "%b[]", "^.().*().$" },
          output = { left = "[", right = "]" },
        },
        B = {
          input = { "%b{}", "^.().*().$" },
          output = { left = "{", right = "}" },
        },
      },
    })

    vim.keymap.set("n", "sl", "sa_", { remap = true })

    vim.keymap.del("x", "sa")
    vim.keymap.set("x", "s", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

    vim.keymap.set("n", [[<leader>"]], [[srq"]], { remap = true })
    vim.keymap.set("n", [[<leader>']], [[srq']], { remap = true })
    vim.keymap.set("n", [[<leader>`]], [[srq`]], { remap = true })
  end,
}
