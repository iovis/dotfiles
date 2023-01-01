local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = { "NeoTree" },
  keys = {
    {
      "<leader>k",
      "<cmd>NeoTreeFocusToggle<cr>",
    },
    {
      "-",
      "<cmd>NeoTreeRevealToggle<cr>",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require("neo-tree").setup({
    enable_diagnostics = false,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
      window = {
        mappings = {
          ["<s-down>"] = "next_git_modified",
          ["<s-up>"] = "prev_git_modified",
          ["ñ"] = "fuzzy_finder",
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            end
          end,
        },
      },
    },
  })

  local u = require("user.utils")
  u.highlight("NeoTreeEndOfBuffer", { fg = "#181818" })
  u.highlight("NeoTreeStatusLine", { fg = "#181818" })
  u.highlight("NeoTreeStatusLineNC", {})
  u.highlight("NeoTreeWinSeparator", { fg = "#181818" })
end

return M
