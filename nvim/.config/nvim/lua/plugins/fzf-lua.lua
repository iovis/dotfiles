return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local fzf_lua = require("fzf-lua")

    ---- Register fzf-lua as the UI interface for vim.ui.select
    fzf_lua.register_ui_select(function(_, items)
      local min_h = 0.15
      local max_h = 0.70

      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end

      return { winopts = { height = h, width = 0.50, row = 0.40 } }
    end)

    local function buf_tmap(lhs, rhs)
      vim.keymap.set("t", lhs, rhs, { buffer = true })
    end

    ---- Config
    fzf_lua.setup({
      winopts = {
        hl = {
          border = "FloatBorder",
        },
        preview = {
          scrollbar = false,
        },
        window_on_create = function()
          buf_tmap("<c-j>", "<down>")
          buf_tmap("<c-k>", "<up>")
          buf_tmap("<m-left>", "<s-left>")
          buf_tmap("<m-right>", "<s-right>")
          buf_tmap("<m-+>", "]")
          buf_tmap("<m-ç>", "}")
          buf_tmap("<m-ñ>", "~")
        end,
      },
      keymap = {
        builtin = {
          ["<c-h>"] = "toggle-help",
          ["<m-p>"] = "toggle-preview",
          ["<m-r>"] = "toggle-preview-cw",
          -- defaults (overridden otherwise)
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
      },
      actions = {
        files = {
          ["default"] = fzf_lua.actions.file_edit,
          -- defaults (overriden otherwise)
          ["ctrl-s"] = fzf_lua.actions.file_split,
          ["ctrl-v"] = fzf_lua.actions.file_vsplit,
          ["ctrl-t"] = fzf_lua.actions.file_tabedit,
          ["alt-q"] = fzf_lua.actions.file_sel_to_qf,
        },
      },
      previewers = {
        git_diff = {
          pager = "delta --width $FZF_PREVIEW_COLUMNS --file-style omit --hunk-header-style omit",
        },
      },
      git = {
        icons = {
          ["?"] = { icon = "?", color = "magenta" },
          ["A"] = { icon = "+", color = "green" },
          ["D"] = { icon = "✗", color = "red" },
          ["M"] = { icon = "*", color = "yellow" },
          ["R"] = { icon = "➜", color = "yellow" },
        },
      },
      grep = {
        -- Don't search on the filename, just the content
        fzf_opts = {
          ["--delimiter"] = ":",
          ["--nth"] = "4..",
        },
        rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case -g '!Session.vim' -g '!.venv' -g '!.git']],
      },
    })

    ---- Keymaps
    vim.keymap.set("n", "z<space>", ":FzfLua<space>")

    vim.keymap.set("n", "<space>r", fzf_lua.resume, { desc = "fzf_lua.resume" })
    vim.keymap.set("n", "<leader>j", fzf_lua.git_status, { desc = "fzf_lua.git_status" })
    vim.keymap.set("n", "<leader>o", fzf_lua.files, { desc = "fzf_lua.files" })
    vim.keymap.set("n", "gm", fzf_lua.buffers, { desc = "fzf_lua.buffers" })

    vim.keymap.set("n", "<leader>ft", function()
      fzf_lua.filetypes({
        winopts = {
          width = 0.50,
          height = 0.75,
        },
      })
    end, { desc = "fzf_lua.filetypes" })

    -- Edit dotfiles
    vim.keymap.set("n", "<leader>ud", function()
      fzf_lua.files({ cwd = "~/.dotfiles/nvim/.config/nvim/" })
    end, { desc = "Open Dotfiles" })

    -- Obsidian
    -- vim.keymap.set("n", "<leader>uo", function()
    --   fzf_lua.files({
    --     cwd = "~/vaults/io",
    --     fd_opts = "-e md",
    --   })
    -- end, { desc = "Open Obsidian note" })
    --
    -- vim.keymap.set("n", "<leader>fn", function()
    --   fzf_lua.grep({
    --     cwd = "~/vaults/io",
    --     no_esc = true, -- Allow regex in search
    --     rg_glob = true, -- Allow glob after `--` in search
    --     search = "\\S -- *.md",
    --   })
    -- end, { desc = "Search Obsidian notes" })

    -- Files
    local original_fd_opts = fzf_lua.config.globals.files.fd_opts
    local fd_opts_no_ignore = table.concat({
      original_fd_opts,
      "--no-ignore",
      "--exclude '.keep'",
      "--exclude 'Session.vim'",
    }, " ")

    -- vim.keymap.set("n", "<leader>o", function()
    --   fzf_lua.files({ fd_opts = original_fd_opts .. [[ --exclude '.venv' ]] })
    -- end, { desc = "fzf_lua.files" })

    vim.keymap.set("n", "<leader>O", function()
      fzf_lua.files({ fd_opts = fd_opts_no_ignore })
    end, { desc = "fzf_lua.all_files" })

    -- Ripgrep search
    vim.keymap.set("x", "<leader>fk", fzf_lua.grep_visual, { silent = true, desc = "fzf_lua.grep" })
    vim.keymap.set("n", "<leader>fk", function()
      fzf_lua.grep({ no_esc = true, search = "\\w" })
    end, { desc = "fzf_lua.grep" })

    vim.keymap.set("n", "<leader>fl", fzf_lua.live_grep, { silent = true, desc = "fzf_lua.live_grep" })

    -- Registers
    local run_macro = function(selected)
      local reg = selected[1]:match("%[(.-)%]")
      local ok, data = pcall(vim.fn.getreg, reg)

      if ok and #data > 0 then
        vim.cmd.normal("@" .. reg)
      end
    end

    local delete_register = function(selected)
      for _, item in ipairs(selected) do
        local reg = item:match("%[(.-)%]")
        vim.fn.setreg(reg:lower(), "")
      end
    end

    fzf_lua.config.set_action_helpstr(run_macro, "run-macro")
    fzf_lua.config.set_action_helpstr(delete_register, "delete-register")

    vim.keymap.set("n", "<leader>R", function()
      local opts = {}

      opts.actions = {
        ["@"] = run_macro,
        ["ctrl-x"] = delete_register,
      }

      fzf_lua.registers(opts)
    end, { desc = "fzf_lua.registers" })
  end,
}
