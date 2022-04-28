local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local ft_functions = require("luasnip.extras.filetype_functions")

---- Config
luasnip.config.set_config({
  -- history = true,
  -- enable_autosnippets = true,
  delete_check_events = "TextChanged,InsertLeave",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "DiagnosticSignWarn" } },
      },
    },
  },
  ft_func = ft_functions.from_pos_or_filetype,
  updateevents = "TextChanged,TextChangedI",
})

---- Load Snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

---- Language config
luasnip.filetype_extend("ruby", { "rails" })
luasnip.filetype_extend("gitcommit", { "markdown" })
luasnip.filetype_extend("pullrequest", { "markdown", "gitcommit" })

---- Keymaps
-- Expansion
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end)

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-h>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)

-- Edit
vim.keymap.set("n", "<leader>ss", "<cmd>LuaSnipListAvailable<cr>")
vim.keymap.set("n", "<leader>ue", require("luasnip.loaders.from_lua").edit_snippet_files)

-- On the fly snippets (use snippet in register s). Use $word as placeholder.
-- Example: Hello $World!
vim.keymap.set("x", "<c-s>", '"sc<cmd>lua require("luasnip.extras.otf").on_the_fly()<cr>')
vim.keymap.set("i", "<c-s>", function()
  require("luasnip.extras.otf").on_the_fly("s")
end)
