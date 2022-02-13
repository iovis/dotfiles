local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local u = require("utils")

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

---- Snippets editing
_G.snippets_clear = function()
  -- Clear snippets
  for m, _ in pairs(luasnip.snippets) do
    package.loaded["snippets." .. m] = nil
  end

  luasnip.snippets = setmetatable({}, {
    __index = function(t, k)
      local ok, m = pcall(require, "snippets." .. k)
      if not ok and not string.match(m, "^module.*not found:") then
        error(m)
      end

      t[k] = ok and m or {}

      -- optionally load snippets from vscode- or snipmate-library:
      require("luasnip.loaders.from_vscode").load()
      require("luasnip.loaders.from_snipmate").load()

      return t[k]
    end,
  })
end

_G.snippets_clear()

-- Reload snippets after editing
vim.cmd([[
  augroup snippets_clear
    au!
    au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
  augroup END
]])

_G.luasnip_edit_ft = function()
  -- returns table like {"lua", "all"}
  local fts = require("luasnip.util.util").get_snippet_filetypes()

  vim.ui.select(fts, {
    prompt = "Select which filetype to edit:",
  }, function(item, idx)
    -- selection aborted -> idx == nil
    if idx then
      vim.cmd("edit ~/.config/nvim/lua/snippets/" .. item .. ".lua")
    end
  end)
end

vim.cmd([[
  command! LuaSnipEdit :lua _G.luasnip_edit_ft()
]])

---- Language config (TODO: should this be moved to filetype snippets?)
luasnip.filetype_extend("ruby", { "rails" })
luasnip.filetype_extend("gitcommit", { "markdown" })
luasnip.filetype_extend("pullrequest", { "markdown", "gitcommit" })

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

-- Expansion
u.imap("<c-j>", "<cmd>lua luasnip_next()<cr>")
u.smap("<c-j>", "<cmd>lua luasnip_next()<cr>")

u.imap("<c-k>", "<cmd>lua luasnip_prev()<cr>")
u.smap("<c-k>", "<cmd>lua luasnip_prev()<cr>")

u.imap("<c-_>", "<cmd>lua luasnip_next_choice()<cr>")
u.smap("<c-_>", "<cmd>lua luasnip_next_choice()<cr>")

-- Edit
u.nmap("<leader>ss", ":LuaSnipListAvailable<cr>")
u.nmap("<leader>ue", ":LuaSnipEdit<cr>")

-- On the fly snippets (use snippet in register s). Use $word as placeholder.
-- Example: Hello $World!
u.xmap("<c-s>", '"sc<cmd>lua require("luasnip.extras.otf").on_the_fly()<cr>')
u.imap("<c-s>", '<cmd>lua require("luasnip.extras.otf").on_the_fly("s")<cr>')

-------------------------------------------------------------------------------
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
