require('map_helpers')

local original_fd_opts = require('fzf-lua.config').globals.files.fd_opts
local original_rg_opts = require('fzf-lua.config').globals.grep.rg_opts

require('fzf-lua').setup {
  winopts = {
    window_on_create = function()
      tnoremap_bs("<c-j>", "<down>")
      tnoremap_bs("<c-k>", "<up>")
      tnoremap_bs("<m-left>", "<s-left>")
      tnoremap_bs("<m-right>", "<s-right>")
      tnoremap_bs("<m-+>", "]")
      tnoremap_bs("<m-ç>", "}")
      tnoremap_bs("<m-ñ>", "~")
    end
  },
  keymap = {
    builtin = {
      ["º"]    = "toggle-preview",
      ["<F1>"] = "preview-page-reset",
      -- defaults (overridden otherwise)
      ["<F2>"] = "toggle-fullscreen",
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
    }
  },
  files = {
    fd_opts = original_fd_opts .. [[ --no-ignore --exclude '.keep' --exclude 'Session.vim']]
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
      ['--delimiter'] = ':',
      ['--nth'] = '4..',
    },
    rg_opts = original_rg_opts .. [[ -g '!Session.vim']]
  }
}

nnoremap('+s', ':FzfLua<space>')

nnoremap_s('+f', '<cmd>FzfLua live_grep<cr>')
nnoremap_s('+m', '<cmd>FzfLua marks<cr>')
nnoremap_s('+r', '<cmd>FzfLua registers<cr>')
nnoremap_s('<c-p>', '<cmd>FzfLua commands<cr>')
nnoremap_s('<leader><leader>', '<cmd>FzfLua buffers<cr>')
nnoremap_s('<leader>A', '<cmd>FzfLua filetypes<cr>')
nnoremap_s('<leader>H', '<cmd>FzfLua git_bcommits<cr>')
nnoremap_s('<leader>O', '<cmd>FzfLua files<cr>')
nnoremap_s('<leader>R', '<cmd>FzfLua tags<cr>')
nnoremap_s('<leader>f', '<cmd>FzfLua grep<cr><cr>')
nnoremap_s('<leader>gL', '<cmd>FzfLua git_commits<cr>')
nnoremap_s('<leader>gco', '<cmd>FzfLua git_branches<cr>')
nnoremap_s('<leader>j', '<cmd>FzfLua git_status<cr>')
nnoremap_s('<leader>o', '<cmd>FzfLua git_files<cr>')
nnoremap_s('<leader>r', '<cmd>FzfLua btags<cr>')
nnoremap_s('<leader>ñ', '<cmd>FzfLua blines<cr>')

xnoremap_s('<leader>f', '<cmd><c-u>FzfLua grep_visual<cr>')
