local cmp = require("cmp")

-- Pretty LSP menu
local lspkind = require("lspkind")
lspkind.init()

-- Autoloading of plugins.cmp.*
local scan = require("plenary.scandir")
local cmp_sources_path = vim.fn.stdpath("config") .. "/lua/plugins/cmp"
local paths = scan.scan_dir(cmp_sources_path, { depth = 0 })

for _, file in ipairs(paths) do
  local source = file:match("([^/]+).lua$")

  require("plugins.cmp." .. source)
end

-- local check_backspace = function()
--   local col = vim.fn.col(".") - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
-- end

cmp.setup({
  mapping = {
    ["<C-b>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.config.disable,
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.config.disable,
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    -- ["<Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif check_backspace() then
    --     fallback()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<S-Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      },
    }),
  },
  sources = {
    { name = "luasnip" },
    { name = "gh_source" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  },
})

-- Colors
local u = require("utils")

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
