local bufferline = require("bufferline")

bufferline.setup({
  highlights = {
    indicator_selected = {
      guifg = {
        attribute = "bg",
        highlight = "HighlightedyankRegion",
      },
    },
  },
  options = {
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
    end,
    numbers = function(opts)
      return string.format("%s.", opts.ordinal)
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { "", "" },
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        highlight = "Directory",
        text_align = "center",
      },
      {
        filetype = "undotree",
        text = "Undo Tree",
        highlight = "Directory",
        text_align = "center",
      },
    },
  },
})

vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>")

-- nnoremap <silent> <leader>1 <cmd>BufferLineGoToBuffer 1<cr>
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    bufferline.go_to_buffer(i)
  end, { desc = "Go to buffer " .. i })
end
