return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    ----Theme
    local colors = require("catppuccin.palettes").get_palette()
    local theme = {
      normal = {
        a = {
          fg = colors.mantle,
          bg = colors.blue,
        },
        b = {
          fg = colors.overlay0,
          -- bg = colors.surface0,
        },
        c = {},
        y = {
          fg = colors.overlay0,
        },
      },

      insert = {
        a = {
          fg = colors.mantle,
          bg = colors.green,
        },
      },
      visual = {
        a = {
          fg = colors.mantle,
          bg = colors.mauve,
        },
      },
      replace = {
        a = {
          fg = colors.mantle,
          bg = colors.red,
        },
      },

      inactive = {
        a = { fg = colors.text },
        b = { fg = colors.text },
        c = { fg = colors.mantle },
      },
    }

    ----Helper functions

    --- Truncate component to `len` characters
    --- @param len number
    local function truncate(len)
      return function(str)
        if #str <= len then
          return str
        end

        return str:sub(1, len - 3) .. "..."
      end
    end

    ----Setup
    require("lualine").setup({
      options = {
        theme = theme,
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        refresh = {
          statusline = 200,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            -- icon = "",
          },
        },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            padding = {
              left = 2,
              right = 0,
            },
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "",
            },
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            "branch",
            fmt = truncate(20),
          },
          "filetype",
          {
            "progress",
            icon = "",
          },
        },
        lualine_z = {}, -- bg color same as "mode"
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
