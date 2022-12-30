local M = {
  "folke/trouble.nvim",
  enabled = false
}

function M.config()
  local ok, trouble = pcall(require, "trouble")
  if not ok then
    print("trouble not found!")
    return
  end

  -- nnoremap ç <cmd>TroubleToggle quickfix<cr>
  -- nnoremap Ç <cmd>TroubleToggle loclist<cr>
  --
  -- augroup trouble
  --   autocmd!
  --   autocmd FileType Trouble setlocal relativenumber
  -- augroup END
  trouble.setup({
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    padding = false,
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      toggle_preview = "p",
    },
  })

  vim.keymap.set("n", "<leader>ç", "<cmd>TroubleToggle<cr>")

  vim.cmd([[
  " hi TroubleIndent   ctermfg=8  ctermbg=NONE guifg=#585858 guibg=NONE
  hi TroubleFoldIcon ctermfg=20 ctermbg=NONE gui=bold guifg=#b8b8b8 guibg=NONE
  " hi TroubleSignError ctermbg=NONE guibg=NONE
  " hi TroubleSignWarning ctermbg=NONE guibg=NONE
  " hi TroubleSignOther ctermbg=NONE guibg=NONE
  " hi TroubleSignHint ctermbg=NONE guibg=NONE
  ]])
end

return M
