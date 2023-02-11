return {
  "feline-nvim/feline.nvim",
  event = "VeryLazy",
  config = function()
    -- Stolen from:
    -- https://github.com/NvChad/NvChad/blob/main/lua/plugins/configs/statusline.lua
    local feline = require("feline")
    local lsp = require("feline.providers.lsp")
    local lsp_severity = vim.diagnostic.severity

    ---- Colors
    -- Stolen from:
    -- https://github.com/NvChad/base46/blob/master/lua/hl_themes/tomorrow_night.lua
    --
    -- TODO: translate to catppuccin
    -- local c = require("catppuccin.palettes").get_palette()
    --
    local colors = {
      white = "#C5C8C2",
      black = "#1d1f21", -- nvim bg
      one_bg = "#363a41",
      one_bg2 = "#353b45",
      grey = "#434547",
      grey_fg2 = "#616875",
      red = "#cc6666",
      pink = "#ff9ca3",
      green = "#a4b595",
      nord_blue = "#728da8",
      yellow = "#d7bd8d",
      dark_purple = "#b290ac",
      teal = "#8abdb6",
      orange = "#DE935F",
      cyan = "#70c0b1",
      statusline_bg = "#212326",
      lightbg = "#373B41",
      lightbg2 = "#2D3035",
    }

    ---- Icon Styles
    local icon_styles = {
      default = {
        left = "",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
      },
      arrow = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
      },

      block = {
        left = " ",
        right = " ",
        main_icon = "   ",
        vi_mode_icon = "  ",
        position_icon = "  ",
      },

      round = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
      },

      slant = {
        left = " ",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
      },
    }

    local separator_style = icon_styles["round"]

    ---- Components
    -- Main icon
    local main_icon = {
      provider = separator_style.main_icon,

      hl = {
        fg = colors.statusline_bg,
        bg = colors.nord_blue,
      },

      right_sep = {
        str = separator_style.right,
        hl = {
          fg = colors.nord_blue,
          bg = colors.lightbg,
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
        fg = colors.white,
        bg = colors.lightbg,
      },

      right_sep = {
        str = separator_style.right,
        hl = { fg = colors.lightbg, bg = colors.lightbg2 },
      },
    }

    local file_name_inactive = {
      provider = file_name_provider,

      hl = {
        fg = colors.grey_fg2,
        bg = colors.lightbg2,
      },

      right_sep = {
        str = separator_style.right,
        hi = {
          fg = colors.lightbg2,
          bg = colors.statusline_bg,
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
        fg = colors.grey_fg2,
        bg = colors.lightbg2,
      },

      right_sep = {
        str = separator_style.right,
        hi = {
          fg = colors.lightbg2,
          bg = colors.statusline_bg,
        },
      },
    }

    -- Git diff
    local diff = {
      add = {
        provider = "git_diff_added",
        hl = {
          fg = colors.grey_fg2,
          bg = colors.statusline_bg,
        },
        icon = "  ",
      },

      change = {
        provider = "git_diff_changed",
        hl = {
          fg = colors.grey_fg2,
          bg = colors.statusline_bg,
        },
        icon = "  ",
      },

      remove = {
        provider = "git_diff_removed",
        hl = {
          fg = colors.grey_fg2,
          bg = colors.statusline_bg,
        },
        icon = "  ",
      },
    }

    -- Git branch
    local git_branch = {
      provider = "git_branch",
      short_provider = "",
      priority = 5,
      hl = {
        fg = colors.grey_fg2,
        bg = colors.statusline_bg,
      },
      icon = "  ",
    }

    -- Diagnostics
    local diagnostic = {
      error = {
        provider = "diagnostic_errors",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.ERROR)
        end,

        hl = { fg = colors.red },
        icon = "  ",
      },

      warning = {
        provider = "diagnostic_warnings",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.WARN)
        end,
        hl = { fg = colors.yellow },
        icon = "  ",
      },

      hint = {
        provider = "diagnostic_hints",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.HINT)
        end,
        hl = { fg = colors.grey_fg2 },
        icon = "  ",
      },

      info = {
        provider = "diagnostic_info",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.INFO)
        end,
        hl = { fg = colors.green },
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

      hl = { fg = colors.green },
    }

    -- LSP icon
    local lsp_icon = {
      provider = function()
        if next(vim.lsp.get_active_clients()) ~= nil then
          return "  LSP "
        else
          return ""
        end
      end,

      short_provider = " ",
      priority = 1,

      hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
    }

    -- Vim mode
    local mode_colors = {
      ["n"] = { "NORMAL", colors.red },
      ["no"] = { "N-PENDING", colors.red },
      ["i"] = { "INSERT", colors.dark_purple },
      ["ic"] = { "INSERT", colors.dark_purple },
      ["t"] = { "TERMINAL", colors.green },
      ["v"] = { "VISUAL", colors.cyan },
      ["V"] = { "V-LINE", colors.cyan },
      [""] = { "V-BLOCK", colors.cyan },
      ["R"] = { "REPLACE", colors.orange },
      ["Rv"] = { "V-REPLACE", colors.orange },
      ["s"] = { "SELECT", colors.nord_blue },
      ["S"] = { "S-LINE", colors.nord_blue },
      ["s"] = { "S-BLOCK", colors.nord_blue },
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
        bg = colors.one_bg,
      }
    end

    local empty_space = {
      provider = " " .. separator_style.left,
      hl = {
        fg = colors.one_bg2,
        bg = colors.statusline_bg,
      },
    }

    -- this matches the vi mode color
    local empty_spaceColored = {
      provider = separator_style.left,
      hl = function()
        return {
          fg = mode_colors[vim.fn.mode()][2],
          bg = colors.one_bg2,
        }
      end,
    }

    local mode_icon = {
      provider = separator_style.vi_mode_icon,
      hl = function()
        return {
          fg = colors.statusline_bg,
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
      provider = separator_style.left,
      hl = {
        fg = colors.grey,
        bg = colors.one_bg,
      },
    }

    local separator_right2 = {
      provider = separator_style.left,
      hl = {
        fg = colors.green,
        bg = colors.grey,
      },
    }

    local separator_right3 = {
      provider = "   " .. separator_style.left,
      hl = {
        fg = colors.lightbg2,
        bg = colors.statusline_bg,
      },
    }

    -- Position
    local position_icon = {
      provider = separator_style.position_icon,
      hl = {
        fg = colors.black,
        bg = colors.green,
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
        fg = colors.green,
        bg = colors.one_bg,
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
    add_table(left, diff.add)
    add_table(left, diff.change)
    add_table(left, diff.remove)
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
        bg = colors.statusline_bg,
        fg = colors.fg,
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
