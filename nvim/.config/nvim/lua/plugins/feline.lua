return {
  "feline-nvim/feline.nvim",
  event = "VeryLazy",
  config = function()
    local feline = require("feline")
    local lsp = require("feline.providers.lsp")
    local lsp_severity = vim.diagnostic.severity
    local colors = require("catppuccin.palettes").get_palette()

    ---- Icon Styles
    local icons = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
    }

    ---- Components
    -- Main icon
    local main_icon = {
      provider = icons.main_icon,

      hl = {
        fg = colors.mantle,
        bg = colors.lavender,
      },

      right_sep = {
        str = icons.right,
        hl = {
          fg = colors.lavender,
          bg = colors.surface1,
        },
      },
    }

    -- File name
    local file_name_provider = function()
      local filetype = vim.bo.filetype

      -- Special filetypes
      if vim.tbl_contains({ "fugitive", "git", "gitcommit" }, filetype) then
        return "  git "
      elseif filetype == "qf" then
        return "  quickfix "
      end

      local devicons = require("nvim-web-devicons")
      local icon = devicons.get_icon_by_filetype(filetype) or ""
      local no_file = "no name"
      local filename = (vim.fn.expand("%") == "" and no_file) or vim.fn.expand("%:t")

      -- if filename ~= no_file then
      --   -- filename exists
      --   local ft_icon = devicons.get_icon(filename)
      --
      --   icon = (ft_icon ~= nil and " " .. ft_icon) or ""
      -- end

      return " " .. icon .. " " .. filename .. " "
    end

    local file_name = {
      provider = file_name_provider,

      hl = {
        fg = colors.text,
        bg = colors.surface1,
      },

      right_sep = {
        str = icons.right,
        hl = {
          fg = colors.surface1,
          bg = colors.surface0,
        },
      },
    }

    local file_name_inactive = {
      provider = file_name_provider,

      hl = {
        fg = colors.overlay0,
        bg = colors.surface0,
      },

      right_sep = {
        str = icons.right,
        hi = {
          fg = colors.surface0,
          -- bg = "none",
        },
      },
    }

    -- Dir name
    local dir_name = {
      provider = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return "  " .. dir_name .. " "
      end,

      short_provider = " ",

      hl = {
        fg = colors.overlay0,
        bg = colors.surface0,
      },

      right_sep = {
        str = icons.right,
        hl = {
          fg = colors.surface0,
          bg = "none",
        },
      },
    }

    -- Git diff
    local diff = {
      add = {
        provider = "git_diff_added",
        hl = {
          fg = colors.overlay0,
          bg = "none",
        },
        icon = "  ",
      },

      change = {
        provider = "git_diff_changed",
        hl = {
          fg = colors.overlay0,
          bg = "none",
        },
        icon = "  ",
      },

      remove = {
        provider = "git_diff_removed",
        hl = {
          fg = colors.overlay0,
          bg = "none",
        },
        icon = "  ",
      },
    }

    -- Diagnostics
    local diagnostic = {
      error = {
        provider = "diagnostic_errors",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.ERROR)
        end,
        hl = {
          fg = colors.red,
          bg = "none",
        },
        icon = "  ",
      },

      warning = {
        provider = "diagnostic_warnings",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.WARN)
        end,
        hl = {
          fg = colors.yellow,
          bg = "none",
        },
        icon = "  ",
      },

      hint = {
        provider = "diagnostic_hints",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.HINT)
        end,
        hl = {
          fg = colors.teal,
          bg = "none",
        },
        icon = "  ",
      },

      info = {
        provider = "diagnostic_info",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.INFO)
        end,
        hl = {
          fg = colors.sky,
          bg = "none",
        },
        icon = "  ",
      },
    }

    -- LSP progress
    local lsp_progress = {
      provider = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]

        if Lsp then
          local msg = Lsp.message or ""
          local percentage = Lsp.percentage or 0
          local title = Lsp.title or ""
          local spinners = {
            "",
            "",
            "",
          }

          local success_icon = {
            "",
            "",
            "",
          }

          local ms = vim.loop.hrtime() / 1000000
          local frame = math.floor(ms / 120) % #spinners

          if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
          end

          return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
        end

        return ""
      end,

      hl = {
        fg = colors.lavender,
        bg = "none",
      },
    }

    -- LSP icon
    local lsp_icon = {
      provider = function()
        if next(vim.lsp.get_active_clients()) ~= nil then
          return " LSP "
        else
          return ""
        end
      end,

      short_provider = " ",
      priority = 1,

      hl = {
        fg = colors.overlay0,
        bg = "none",
      },
    }

    -- Git branch
    local git_branch = {
      provider = "git_branch",
      short_provider = "",
      priority = 5,
      hl = {
        fg = colors.overlay0,
        bg = "none",
      },
      icon = "  ",
    }

    -- Vim mode
    local mode_colors = {
      ["n"] = { "NORMAL", colors.red },
      ["no"] = { "N-PENDING", colors.red },
      ["i"] = { "INSERT", colors.mauve },
      ["ic"] = { "INSERT", colors.mauve },
      ["t"] = { "TERMINAL", colors.green },
      ["v"] = { "VISUAL", colors.sapphire },
      ["V"] = { "V-LINE", colors.sapphire },
      [""] = { "V-BLOCK", colors.sapphire },
      ["R"] = { "REPLACE", colors.peach },
      ["Rv"] = { "V-REPLACE", colors.peach },
      ["s"] = { "SELECT", colors.lavender },
      ["S"] = { "S-LINE", colors.lavender },
      ["s"] = { "S-BLOCK", colors.lavender },
      ["c"] = { "COMMAND", colors.pink },
      ["cv"] = { "COMMAND", colors.pink },
      ["ce"] = { "COMMAND", colors.pink },
      ["r"] = { "PROMPT", colors.teal },
      ["rm"] = { "MORE", colors.teal },
      ["r?"] = { "CONFIRM", colors.teal },
      ["!"] = { "SHELL", colors.green },
    }

    local chad_mode_hl = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = colors.surface0,
      }
    end

    local empty_space = {
      provider = " " .. icons.left,
      hl = {
        fg = colors.surface1,
        bg = "none",
      },
    }

    -- this matches the vi mode color
    local empty_spaceColored = {
      provider = icons.left,
      hl = function()
        return {
          fg = mode_colors[vim.fn.mode()][2],
          bg = colors.surface1,
        }
      end,
    }

    local mode_icon = {
      provider = icons.vi_mode_icon,
      hl = function()
        return {
          fg = colors.mantle,
          bg = mode_colors[vim.fn.mode()][2],
        }
      end,
    }

    local empty_space2 = {
      provider = function()
        return " " .. mode_colors[vim.fn.mode()][1] .. " "
      end,
      short_provider = "",
      priority = 2,
      hl = chad_mode_hl,
    }

    local separator_right = {
      provider = icons.left,
      hl = {
        fg = colors.surface1,
        bg = colors.surface0,
      },
    }

    local separator_right2 = {
      provider = icons.left,
      hl = {
        fg = colors.teal,
        bg = colors.surface1,
      },
    }

    local separator_right3 = {
      provider = "   " .. icons.left,
      hl = {
        fg = colors.surface0,
        -- bg = "none",
      },
    }

    -- Position
    local position_icon = {
      provider = icons.position_icon,
      hl = {
        fg = colors.mantle,
        bg = colors.teal,
      },
    }

    local current_line = {
      provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")

        if current_line == 1 then
          return " Top "
        elseif current_line == vim.fn.line("$") then
          return " Bot "
        end

        local result, _ = math.modf((current_line / total_line) * 100)

        return " " .. result .. "%% "
      end,

      hl = {
        fg = colors.teal,
        bg = colors.surface0,
      },
    }

    ---- Sections
    local function add_table(a, b)
      table.insert(a, b)
    end

    -- components are divided in 3 sections
    local left = {}
    local middle = {}
    local right = {}

    -- left
    add_table(left, main_icon)
    add_table(left, file_name)
    add_table(left, dir_name)
    -- add_table(left, diff.add)
    -- add_table(left, diff.change)
    -- add_table(left, diff.remove)
    add_table(left, diagnostic.error)
    add_table(left, diagnostic.warning)
    add_table(left, diagnostic.hint)
    add_table(left, diagnostic.info)

    add_table(middle, lsp_progress)

    -- right
    add_table(right, lsp_icon)
    add_table(right, git_branch)
    add_table(right, empty_space)
    add_table(right, empty_spaceColored)
    add_table(right, mode_icon)
    add_table(right, empty_space2)
    add_table(right, separator_right)
    add_table(right, separator_right2)
    add_table(right, position_icon)
    add_table(right, current_line)

    --- Inactive
    local left_inactive = {}
    add_table(left_inactive, separator_right3)
    add_table(left_inactive, file_name_inactive)

    ---- Setup
    feline.setup({
      theme = {
        bg = colors.base,
      },
      components = {
        active = {
          left,
          middle,
          right,
        },
        inactive = {
          left_inactive,
        },
      },
      disable = {
        filetypes = {
          "^NvimTree$",
          "^neo%-tree$",
          "^dapui_.*",
          "^dap-repl$",
        },
      },
    })
  end,
}
