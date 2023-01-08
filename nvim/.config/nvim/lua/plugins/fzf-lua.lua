local M = {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = {
    "vijaymarupudi/nvim-fzf",
    "nvim-tree/nvim-web-devicons",
    {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },
  },
}

function M.config()
  local ok, fzf_lua = pcall(require, "fzf-lua")
  if not ok then
    print("fzf-lua not found!")
    return
  end

  -- register fzf-lua as the UI interface for vim.ui.select
  fzf_lua.register_ui_select()

  local fzf_actions = require("fzf-lua.actions")

  local function buf_tmap(lhs, rhs)
    vim.keymap.set("t", lhs, rhs, { buffer = true })
  end

  ---- Config
  fzf_lua.setup({
    winopts = {
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
        ["<m-p>"] = "toggle-preview",
        ["<c-h>"] = "toggle-help",
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
      rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case -g '!Session.vim' -g '!sorbet' -g '!.git']],
    },
    actions = {
      files = {
        ["default"] = fzf_actions.file_edit,
        -- defaults (overriden otherwise)
        ["ctrl-s"] = fzf_actions.file_split,
        ["ctrl-v"] = fzf_actions.file_vsplit,
        ["ctrl-t"] = fzf_actions.file_tabedit,
        ["alt-q"] = fzf_actions.file_sel_to_qf,
      },
    },
    previewers = {
      git_diff = {
        pager = "delta --width $FZF_PREVIEW_COLUMNS",
      },
    },
  })

  ---- Keymaps
  vim.keymap.set("n", "+f", ":FzfLua<space>")

  -- vim.keymap.set("n", "+m", fzf_lua.marks, { desc = "fzf_lua.marks" })
  vim.keymap.set("n", "<c-p>", fzf_lua.commands, { desc = "fzf_lua.commands" })
  vim.keymap.set("n", "<leader><leader>", fzf_lua.buffers, { desc = "fzf_lua.buffers" })
  vim.keymap.set("n", "<leader>A", fzf_lua.filetypes, { desc = "fzf_lua.filetypes" })
  vim.keymap.set("n", "<leader>R", fzf_lua.tags, { desc = "fzf_lua.tags" })
  vim.keymap.set("n", "<leader>gH", fzf_lua.git_bcommits, { desc = "fzf_lua.git_bcommits" })
  vim.keymap.set("n", "<leader>gL", fzf_lua.git_commits, { desc = "fzf_lua.git_commits" })
  vim.keymap.set("n", "<leader>gco", fzf_lua.git_branches, { desc = "fzf_lua.git_branches" })
  vim.keymap.set("n", "<leader>j", fzf_lua.git_status, { desc = "fzf_lua.git_status" })
  vim.keymap.set("n", "<leader>r", fzf_lua.btags, { desc = "fzf_lua.btags" })
  vim.keymap.set("n", "<leader>ñ", fzf_lua.blines, { desc = "fzf_lua.blines" })

  vim.keymap.set("n", "<m-f>", fzf_lua.resume, { desc = "fzf_lua.resume" })
  vim.keymap.set("n", "ƒ", fzf_lua.resume, { desc = "fzf_lua.resume" })

  -- Edit dotfiles
  vim.keymap.set("n", "<leader>ue", function()
    fzf_lua.files({ cwd = "~/.dotfiles/" })
  end)

  -- Edit snippets
  local original_fd_opts = require("fzf-lua.config").globals.files.fd_opts
  local fd_opts_no_ignore = table.concat({
    original_fd_opts,
    "--no-ignore",
    "--exclude '.keep'",
    "--exclude 'Session.vim'",
  }, " ")

  vim.keymap.set("n", "<leader>se", function()
    local filetype = require("luasnip.extras.filetype_functions").from_pos_or_filetype()[1]

    -- fzf_query: 'snippets 'all | '<filetype>.
    local query = [["'snippets 'all | ']] .. filetype .. '."'

    fzf_lua.files({
      cwd = "~/.dotfiles/nvim/",
      fzf_opts = { ["--query"] = query },
    })
  end)

  -- Files
  vim.keymap.set("n", "<leader>o", function()
    fzf_lua.files({ fd_opts = original_fd_opts .. [[ --exclude 'sorbet' ]] })
  end, { desc = "fzf_lua.files" })

  vim.keymap.set("n", "<leader>O", function()
    fzf_lua.files({ fd_opts = fd_opts_no_ignore })
  end, { desc = "fzf_lua.all_files" })

  -- vim.keymap.set("n", "+t", function()
  --   fzf_lua.files({ fd_opts = original_fd_opts .. [[ -e 'rbi' ]] })
  -- end, { desc = "fzf_lua.sorbet_files" })

  -- Ripgrep search
  vim.keymap.set("n", "<leader>f", function()
    fzf_lua.grep({ no_esc = true, search = "\\w" })
  end, { desc = "fzf_lua.grep" })

  vim.keymap.set("x", "<leader>f", fzf_lua.grep_visual, { silent = true, desc = "fzf_lua.grep" })

  -- Registers (paste register or apply macro)
  local extract_register_from = function(result)
    -- `selected[1]` is going to be "[2] contents of register 2"
    return result:match("%[(.-)%]")
  end

  -- vim.keymap.set("n", "+r", function()
  --   local opts = {}
  --
  --   opts.actions = {
  --     ["@"] = function(selected)
  --       local register = extract_register_from(selected[1])
  --       vim.cmd.normal("@" .. register)
  --     end,
  --   }
  --
  --   fzf_lua.registers(opts)
  -- end, { desc = "fzf_lua.registers" })
end

return M
