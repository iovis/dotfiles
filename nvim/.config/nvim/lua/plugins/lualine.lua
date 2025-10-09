return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = require("catppuccin.palettes").get_palette()
    local u = require("config.utils")

    ----Helper functions
    ---Truncate component to `len` characters
    ---@param len number
    ---@return fun(string): string
    local function truncate(len)
      return function(str)
        return u.truncate(str, len)
      end
    end

    ----Sections
    local block = {
      {
        function()
          return " "
        end,
        padding = 0,
        color = { bg = colors.mantle },
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
        -- Copilot status
        function()
          if vim.fn["copilot#Enabled"]() == 1 then
            return " "
          else
            return " "
          end
        end,
      },
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
        -- <percentage>:<total lines> [23%:123]
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
      filetypes = { "qf" },
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
                local total_pages = vim.fn.getqflist({ nr = "$" }).nr
                local qf = vim.fn.getqflist({ nr = 0, title = 0 })

                return ("[%d/%d] %s"):format(qf.nr, total_pages, qf.title)
              end
            end,
          },
        },
        lualine_y = status,
      },
    }

    ----Components
    local function muxi_marks()
      local marks = require("muxi").marks_for_current_file()
      if vim.tbl_isempty(marks) then
        return ""
      end

      -- Sort by position in the file
      table.sort(marks, function(a, b)
        return a.pos[1] < b.pos[1]
      end)

      local keys = vim
        .iter(marks)
        :map(function(mark)
          return mark.key
        end)
        :join(" ")

      return "[" .. keys .. "]"
    end

    ----Setup
    require("lualine").setup({
      options = {
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        refresh = { statusline = 200 },
        theme = {
          normal = {
            a = { fg = colors.blue, bg = colors.mantle },
            b = { fg = colors.overlay0 },
            c = {},
            x = { fg = colors.peach },
            y = { fg = colors.overlay0 },
            z = { fg = colors.blue, bg = colors.mantle },
          },
          inactive = {
            a = { fg = colors.text, bg = colors.mantle },
            b = { fg = colors.text, bg = colors.mantle },
            c = { fg = colors.mantle, bg = colors.mantle },
          },
        },
      },
      sections = {
        lualine_a = block,
        lualine_b = filename,
        lualine_c = { "diagnostics" },
        lualine_x = { muxi_marks },
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
        "fugitive",
        "lazy",
        "mason",
        "oil",
        "toggleterm",
        qf,
      },
    })
  end,
}
