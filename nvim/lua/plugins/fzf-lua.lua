local u = require("utils")

local original_fd_opts = require("fzf-lua.config").globals.files.fd_opts
-- local original_rg_opts = require("fzf-lua.config").globals.grep.rg_opts

local function buf_tmap(...)
  u.buf_map(0, "t", ...)
end

require("fzf-lua").setup({
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
      ["<F1>"] = "preview-page-reset",
      -- defaults (overridden otherwise)
      ["<F2>"] = "toggle-fullscreen",
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
    },
  },
  files = {
    fd_opts = original_fd_opts .. [[ --no-ignore --exclude '.keep' --exclude 'Session.vim']],
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
  -- lsp = {
  --   async = false, -- Asynchronous calls don't work with null-ls
  -- },
})

u.nmap("+s", ":FzfLua<space>", { silent = false })

u.nmap("+f", "<cmd>FzfLua live_grep<cr>")
u.nmap("+m", "<cmd>FzfLua marks<cr>")
u.nmap("+r", "<cmd>FzfLua registers<cr>")
u.nmap("<c-p>", "<cmd>FzfLua commands<cr>")
u.nmap("<leader><leader>", "<cmd>FzfLua buffers<cr>")
u.nmap("<leader>A", "<cmd>FzfLua filetypes<cr>")
u.nmap("<leader>H", "<cmd>FzfLua git_bcommits<cr>")
u.nmap("<leader>O", "<cmd>FzfLua files<cr>")
u.nmap("<leader>R", "<cmd>FzfLua tags<cr>")
u.nmap("<leader>f", "<cmd>FzfLua grep<cr>.<cr>")
u.nmap("<leader>gL", "<cmd>FzfLua git_commits<cr>")
u.nmap("<leader>gco", "<cmd>FzfLua git_branches<cr>")
u.nmap("<leader>j", "<cmd>FzfLua git_status<cr>")
u.nmap("<leader>o", "<cmd>FzfLua git_files<cr>")
u.nmap("<leader>r", "<cmd>FzfLua btags<cr>")
u.nmap("<leader>ñ", "<cmd>FzfLua blines<cr>")

u.xmap("<leader>f", ":<c-u>FzfLua grep_visual<cr>")
