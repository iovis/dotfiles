local fzf_lua = require("fzf-lua")
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
      ["º"] = "toggle-preview",
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
      ["M"] = { icon = "★", color = "yellow" },
      ["R"] = { icon = "➜", color = "yellow" },
    },
  },
  grep = {
    -- Don't search on the filename, just the content
    fzf_opts = {
      ["--delimiter"] = ":",
      ["--nth"] = "4..",
    },
    rg_opts = [[--column --line-number --no-heading --color=always --smart-case -g '!Session.vim']],
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
})

---- TODO: LuaSnip require("luasnip").available()
-- https://github.com/ibhagwan/fzf-lua/issues/57

---- Keymaps
vim.keymap.set("n", "+s", ":FzfLua<space>")

vim.keymap.set("n", "+f", fzf_lua.live_grep)
vim.keymap.set("n", "+m", fzf_lua.marks)
vim.keymap.set("n", "+r", fzf_lua.registers)
vim.keymap.set("n", "<c-p>", fzf_lua.commands)
vim.keymap.set("n", "<leader><leader>", fzf_lua.buffers)
vim.keymap.set("n", "<leader>A", fzf_lua.filetypes)
vim.keymap.set("n", "<leader>R", fzf_lua.tags)
vim.keymap.set("n", "<leader>gL", fzf_lua.git_commits)
vim.keymap.set("n", "<leader>gco", fzf_lua.git_branches)
vim.keymap.set("n", "<leader>gh", fzf_lua.git_bcommits)
vim.keymap.set("n", "<leader>j", fzf_lua.git_status)
vim.keymap.set("n", "<leader>o", fzf_lua.files)
vim.keymap.set("n", "<leader>r", fzf_lua.btags)
vim.keymap.set("n", "<leader>ñ", fzf_lua.blines)

-- Files (no gitignore)
vim.keymap.set("n", "<leader>O", function()
  fzf_lua.files({ fd_opts = fd_opts_no_ignore })
end)

-- Ripgrep search
vim.keymap.set("n", "<leader>f", function()
  fzf_lua.grep({ no_esc = true, search = "\\w" })
end)

vim.keymap.set("x", "<leader>f", fzf_lua.grep_visual, { silent = true })
