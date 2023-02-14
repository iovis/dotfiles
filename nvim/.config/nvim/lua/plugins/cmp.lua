local M = {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "petertriho/cmp-git",
    "quangnguyen30192/cmp-nvim-tags",
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    print("cmp not found!")
    return
  end

  ---- Plugins
  -- Pretty LSP menu
  local lspkind = require("lspkind")
  lspkind.init()

  -- git
  require("cmp_git").setup()

  ---- Setup
  local toggle_completion = function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete({})
    end
  end

  cmp.setup({
    mapping = {
      ["<C-b>"] = { i = toggle_completion },
      ["<C-n>"] = { i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
      ["<C-p>"] = { i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
      ["<Tab>"] = { i = cmp.mapping.confirm({ select = true }) },
    },
    formatting = {
      format = lspkind.cmp_format({
        menu = {
          buffer = "[Buf]",
          git = "[GIT]",
          luasnip = "[Snip]",
          nvim_lsp = "[LSP]",
          path = "[Path]",
          tags = "[TAG]",
        },
      }),
    },
    sources = cmp.config.sources({
      { name = "git" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer", keyword_length = 4 },
      { name = "path" },
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  })

  ---- Modes
  -- Search
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline({
      ["<C-b>"] = { c = toggle_completion },
      ["<C-e>"] = cmp.config.disable,
    }),
    sources = {
      { name = "buffer" },
    },
  })

  -- Command line
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
      ["<C-b>"] = { c = toggle_completion },
      ["<C-e>"] = cmp.config.disable,
    }),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  ---- Filetypes
  cmp.setup.filetype("ruby", {
    sources = cmp.config.sources({
      { name = "tags" },
    }),
  })

  ---- Colors
  -- local hi = require("config.highlights").hi
  -- local c = require("config.highlights").colors
  --
  -- hi.CmpItemAbbr = { fg = c.gray5 }
  --
  -- -- gray
  -- hi.CmpItemAbbrDeprecated = { fg = c.gray3, strikethrough = true }
  --
  -- -- blue
  -- hi.CmpItemAbbrMatch = { fg = c.blue }
  -- hi.CmpItemAbbrMatchFuzzy = { fg = c.blue }
  --
  -- -- light blue
  -- hi.CmpItemKindVariable = { fg = c.cyan }
  -- hi.CmpItemKindInterface = { fg = c.cyan }
  -- hi.CmpItemKindText = { fg = c.cyan }
  --
  -- -- pink
  -- hi.CmpItemKindFunction = { fg = c.magenta }
  -- hi.CmpItemKindMethod = { fg = c.magenta }
  --
  -- -- front
  -- hi.CmpItemKindKeyword = { fg = c.gray5 }
  -- hi.CmpItemKindProperty = { fg = c.gray5 }
  -- hi.CmpItemKindUnit = { fg = c.gray5 }
end

return M
