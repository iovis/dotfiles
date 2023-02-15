return {
  "glepnir/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      code_action = {
        extend_gitsigns = false,
      },
      diagnostic = {
        custom_msg = "■ Diagnostics",
        custom_fix = " Fix",
        keys = {
          exec_action = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
      },
      outline = {
        keys = {
          jump = "<cr>",
          expand_collapse = "x",
        },
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = "",
        -- catppuccin
        -- colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
        -- kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
    })

    -- ---- Highlights
    -- -- https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/highlight.lua
    -- local hi = require("config.highlights").hi
    -- local colors = require("config.highlights").colors
    --
    -- -- General
    -- hi.SagaBorder = { fg = colors.blue }
    -- hi.SagaCollapse = { fg = colors.red }
    -- hi.SagaExpand = { fg = colors.red }
    --
    -- -- Code Action
    -- hi.ActionPreviewNormal = { link = "Comment" }
    -- hi.CodeActionNumber = { fg = colors.green }
    -- hi.CodeActionText = { fg = colors.orange }
    -- hi.LspSagaLightBulb = { fg = colors.yellow }
    --
    -- -- Diagnostic
    -- hi.DiagnosticSource = { link = "Comment" }
    --
    -- -- Finder
    -- hi.FinderIcon = { link = "FinderType" }
    -- hi.FinderSelection = { fg = colors.blue }
    -- hi.FinderSpinner = { link = "FinderSpinnerTitle" }
    -- hi.FinderSpinnerTitle = { fg = colors.blue }
    -- hi.FinderType = { fg = colors.yellow }
    -- hi.FinderVirtText = { link = "Comment" }
    --
    -- -- Rename
    -- hi.RenameNormal = { fg = colors.cyan }
  end,
}
