return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

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

    ----Sections
    local block = {
      {
        function()
          return " "
        end,
        padding = 0,
        color = {
          bg = colors.mantle,
        },
      },
    }

    local filename = {
      {
        "filetype",
        icon_only = true,
        padding = {
          left = 1,
          right = 0,
        },
      },
      {
        "filename",
        -- path = 1, -- Show full path
        symbols = {
          modified = "●",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      },
    }

    local noice_section = {}

    local noice_ok, noice = pcall(require, "noice")
    if noice_ok then
      noice_section = vim.tbl_extend("force", noice_section, {
        {
          -- Show current search
          noice.api.status.search.get,
          cond = noice.api.status.search.has,
          color = { fg = colors.sapphire },
        },
        {
          -- Show "recording" messages
          noice.api.status.mode.get,
          cond = noice.api.status.mode.has,
          color = { fg = colors.peach },
        },
        {
          -- Show number of selected lines in Visual
          function()
            local starts = vim.fn.line("v")
            local ends = vim.fn.line(".")
            local count = math.abs(ends - starts) + 1

            return count .. vim.fn.mode()
          end,
          cond = function()
            return vim.fn.mode():find("[vV]") ~= nil
          end,
          color = { fg = colors.mauve },
        },
        -- {
        --   -- Show current keystroke
        --   noice.api.status.command.get,
        --   cond = noice.api.status.command.has,
        --   color = { fg = colors.overlay0 },
        -- },
      })
    end

    ----Setup
    require("lualine").setup({
      options = {
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        refresh = {
          statusline = 200,
        },
        theme = {
          normal = {
            a = {
              fg = colors.blue,
              bg = colors.mantle,
            },
            b = {
              fg = colors.overlay0,
            },
            c = {},
            y = {
              fg = colors.overlay0,
            },
            z = {
              fg = colors.blue,
              bg = colors.mantle,
            },
          },

          inactive = {
            a = {
              fg = colors.text,
              bg = colors.mantle,
            },
            b = {
              fg = colors.text,
              bg = colors.mantle,
            },
            c = {
              fg = colors.mantle,
              bg = colors.mantle,
            },
          },
        },
      },
      sections = {
        lualine_a = block,
        lualine_b = filename,
        lualine_c = {
          "diagnostics",
        },
        lualine_x = noice_section,
        lualine_y = {
          {
            "diff",
            diff_color = {
              added = "DiffAdded",
              modified = "DiffChanged",
              removed = "DiffRemoved",
            },
          },
          {
            "branch",
            fmt = truncate(20),
          },
          {
            "progress",
            icon = "",
          },
        },
        lualine_z = {}, -- bg color same as "mode"
      },
      inactive_sections = {
        lualine_a = block,
        lualine_b = filename,
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {
        -- "neo-tree",
        "quickfix",
        "fugitive",
      },
    })
  end,
}
