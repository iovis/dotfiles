return {
  "akinsho/nvim-bufferline.lua",
  -- enabled = false,
  event = "TabNew",
  keys = {
    { "<tab>", "<cmd>BufferLineCycleNext<cr>" },
    { "<s-tab>", "<cmd>BufferLineCyclePrev<cr>" },
  },
  config = function()
    require("bufferline").setup({
      -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      highlights = {
        buffer_selected = {
          bg = "NONE",
          fg = "#c6d0f5",
          bold = true,
          italic = false,
        },
        indicator_selected = {
          bg = "NONE",
          bold = true,
          fg = "#8CAAEE",
          italic = false,
        },
      },
      options = {
        mode = "tabs",
        numbers = "none",
        -- indicator = {
        --   style = "underline", -- 'icon' | 'underline' | 'none'
        -- },
        -- custom_filter = function(buf_number, _)
        --   -- filter out filetypes you don't want to see
        --   return vim.bo[buf_number].filetype ~= "qf"
        -- end,
        -- numbers = function(opts)
        --   return string.format("%s.", opts.ordinal)
        -- end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
        separator_style = { "", "" },
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
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

    for i = 1, 5 do
      vim.keymap.set("n", ("<M-%s>"):format(i), function()
        require("bufferline").go_to(i, true)
      end, { desc = "Go to tab " .. i })
    end
  end,
}
