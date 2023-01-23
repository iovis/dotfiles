local M = {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
}

function M.config()
  local ok, luasnip = pcall(require, "luasnip")
  if not ok then
    print("luasnip not found!")
    return
  end

  local types = require("luasnip.util.types")
  local ft_functions = require("luasnip.extras.filetype_functions")

  ---- Config
  luasnip.config.set_config({
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "DiagnosticSignWarn" } },
        },
      },
    },
    ft_func = ft_functions.from_pos_or_filetype,
    history = false,
    region_check_events = "InsertEnter,CursorMoved",
    store_selection_keys = "<c-k>", -- Mapping to visually select text to be expanded with $TM_SELECTED_TEXT
    updateevents = "TextChanged,TextChangedI",
  })

  ---- Load Snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

  ---- Language config
  luasnip.filetype_extend("gitcommit", { "markdown" })
  luasnip.filetype_extend("pullrequest", { "markdown", "gitcommit" })
  luasnip.filetype_extend("scss", { "css" })
  luasnip.filetype_extend("typescript", { "javascript" })

  ---- Keymaps
  -- Expansion
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { desc = "expand or jump" })

  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { desc = "jump back" })

  vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { desc = "next choice" })

  vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(-1)
    end
  end, { desc = "previous choice" })

  -- View/Edit
  vim.keymap.set("n", "<leader>se", require("luasnip.loaders").edit_snippet_files)
  vim.keymap.set("n", "<leader>ss", require("luasnip.extras.snippet_list").open)

  -- On the fly snippets (use snippet in register s). Use $word as placeholder.
  -- Example: Hello $World!
  -- vim.keymap.set("x", "<c-s>", '"sc<cmd>lua require("luasnip.extras.otf").on_the_fly()<cr>')
  -- vim.keymap.set("i", "<c-s>", function()
  --   require("luasnip.extras.otf").on_the_fly("s")
  -- end, { desc = "expand on the fly snippet" })
end

return M
