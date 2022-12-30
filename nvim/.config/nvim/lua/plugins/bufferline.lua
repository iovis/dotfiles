local M = {
  "akinsho/nvim-bufferline.lua",
  event = "BufAdd",
}

function M.config()
  require("bufferline").setup({
    highlights = {
      indicator_selected = {
        fg = {
          attribute = "bg",
          highlight = "HighlightedYankRegion",
        },
      },
    },
    options = {
      custom_filter = function(buf_number, _)
        -- filter out filetypes you don't want to see
        return vim.bo[buf_number].filetype ~= "qf"
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

  -- TODO: move this to `M.init()`?
  vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>")
  vim.keymap.set("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>")

  -- nnoremap <silent> <leader>1 <cmd>BufferLineGoToBuffer 1<cr>
  for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
      require("bufferline").go_to_buffer(i, true)
    end, { desc = "Go to buffer " .. i })
  end
end

return M
