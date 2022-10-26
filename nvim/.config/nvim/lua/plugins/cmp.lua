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
cmp.setup({
  mapping = {
    ["<C-b>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.config.disable,
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.disable,
    ["<CR>"] = cmp.config.disable,
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
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
  sources = {
    { name = "git" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
  },
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

---- Filetypes
cmp.setup.filetype("ruby", {
  sources = cmp.config.sources({
    { name = "tags" },
  }),
})

---- Colors
local u = require("utils")

u.highlight("CmpItemAbbr", { fg = "#d8d8d8" })

-- gray
u.highlight("CmpItemAbbrDeprecated", {
  fg = "#808080",
  strikethrough = true,
})

-- blue
u.highlight("CmpItemAbbrMatch", { fg = "#569CD6" })
u.highlight("CmpItemAbbrMatchFuzzy", { fg = "#569CD6" })

-- light blue
u.highlight("CmpItemKindVariable", { fg = "#9CDCFE" })
u.highlight("CmpItemKindInterface", { fg = "#9CDCFE" })
u.highlight("CmpItemKindText", { fg = "#9CDCFE" })

-- pink
u.highlight("CmpItemKindFunction", { fg = "#C586C0" })
u.highlight("CmpItemKindMethod", { fg = "#C586C0" })

-- front
u.highlight("CmpItemKindKeyword", { fg = "#D4D4D4" })
u.highlight("CmpItemKindProperty", { fg = "#D4D4D4" })
u.highlight("CmpItemKindUnit", { fg = "#D4D4D4" })
