require('bufferline').setup {
  highlights = {
    indicator_selected = {
      guifg = {
        attribute = "bg",
        highlight = "HighlightedyankRegion",
      }
    }
  },
  options = {
    numbers = function(opts)
      return string.format('%s.', opts.ordinal)
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { "", "" },
    offsets = {
      {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center"
      },
      {
          filetype = "undotree",
          text = "Undo Tree",
          highlight = "Directory",
          text_align = "center"
      }
      }
  }
}

-- nnoremap <silent> <leader>1 <cmd>BufferLineGoToBuffer 1<cr>
for i = 1, 9 do
  vim.api.nvim_set_keymap(
    'n',
    '<leader>' .. i,
    ':lua require("bufferline").go_to_buffer(' .. i .. ")<CR>",
    { silent = true, nowait = true, noremap = true }
  )
end

vim.api.nvim_set_keymap(
  'n',
  '<tab>',
  '<cmd>BufferLineCycleNext<cr>',
  { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<s-tab>',
  '<cmd>BufferLineCyclePrev<cr>',
  { silent = true, noremap = true }
)
