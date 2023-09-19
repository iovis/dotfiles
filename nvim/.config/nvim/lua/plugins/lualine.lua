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
    ---
    --- @param len number
    --- @return fun(string): string
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
        path = 1, -- Show full path
        symbols = {
          modified = "●",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      },
    }

    local status = {
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
        function()
          local cur = vim.fn.line(".")
          local total = vim.fn.line("$")
          local progress = math.floor(cur / total * 100) .. "%%"

          return string.format("%5s:%s", progress, total)
        end,
        padding = {
          left = 0,
          right = 1,
        },
      },
    }

    ----Extensions
    local qf = {
      sections = {
        lualine_a = block,
        lualine_b = {
          {
            icon = "",
            function()
              -- Print the title of the quickfix/location list
              local is_loclist = vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0

              if is_loclist then
                return vim.fn.getloclist(0, { title = 0 }).title
              else
                return vim.fn.getqflist({ title = 0 }).title
              end
            end,
          },
        },
        lualine_y = status,
      },
      filetypes = { "qf" },
    }

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
        lualine_x = {},
        lualine_y = status,
        lualine_z = {},
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
        -- "quickfix",
        qf,
        "fugitive",
      },
    })
  end,
}
