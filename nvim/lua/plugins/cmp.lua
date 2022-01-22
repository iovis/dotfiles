local cmp = require("cmp")

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "m",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm(),
    ["<CR>"]  = cmp.config.disable,
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        ultisnips = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "ultisnips" },
    { name = "buffer" },
    { name = "path" },
  },
})
