local luasnip = require("luasnip")
local types = require("luasnip.util.types")

---- Config
luasnip.config.set_config({
  -- history = true,
  updateevents = "TextChanged,TextChangedI",
  -- enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
})

---- Import VS Code snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("ruby", { "rails" })

---- Import Snipmate snippets
-- TODO: migrate to lua
--       - Check how to run shell commands (seems like you can run from a lua function?)
-- require("luasnip.loaders.from_snipmate").load()

---- Commands
-- TODO: Make command to edit nvim/snippets/<filetype>.lua
--       - require("luasnips.extras.filetype_functions").from_pos_or_filetype() ?
--       - Make lua snippet with skeleton?
--       - https://github.com/tjdevries/config_manager/blob/bbf0c735cba0b600708969ffcab9e047efd88676/xdg_config/nvim/after/plugin/luasnip.lua

---- Keymaps
_G.luasnip_next = function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end

_G.luasnip_prev = function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end

_G.luasnip_next_choice = function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end

local u = require("utils")
u.imap("<c-j>", "<cmd>lua luasnip_next()<cr>")
u.smap("<c-j>", "<cmd>lua luasnip_next()<cr>")

u.imap("<c-k>", "<cmd>lua luasnip_prev()<cr>")
u.smap("<c-k>", "<cmd>lua luasnip_prev()<cr>")

u.imap("<c-->", "<cmd>lua luasnip_next_choice()<cr>")
u.smap("<c-->", "<cmd>lua luasnip_next_choice()<cr>")

u.nmap("<leader>ue", ":LuaSnipListAvailable<cr>")
-- vim.keymap.set({ "i", "s" }, "<c-j>", , { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
-- vim.keymap.set({ "i", "s" }, "<c-k>", , { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
-- vim.keymap.set("i", "<c-l>", function()
--   if luasnip.choice_active() then
--     luasnip.change_choice(1)
--   end
-- end)
