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
    window = {
      width = 33,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
      window = {
        mappings = {
          ["!"] = "run_external_command",
          ["."] = "run_command",
          ["<s-down>"] = "next_git_modified",
          ["<s-up>"] = "prev_git_modified",
          ["h"] = "fold_left",
          ["l"] = "fold_right",
          ["ñ"] = "fuzzy_finder",
        },
      },
      commands = {
        -- TODO: Open multiple
        -- open_visual = function(state, selected_nodes)
        --   pp(selected_nodes)
        -- end,
        run_command = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()

          vim.api.nvim_input(": " .. path .. "<Home>")
        end,
        run_external_command = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()

          vim.api.nvim_input(":! " .. path .. "<Home><Right>")
        end,
        fold_left = function(state)
          local node = state.tree:get_node()

          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        fold_right = function(state)
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
  })

  local hi = require("user.utils").hi

  hi.NeoTreeEndOfBuffer = { fg = "#181818" }
  hi.NeoTreeStatusLine = { fg = "#181818" }
  hi.NeoTreeStatusLineNC = {}
  hi.NeoTreeWinSeparator = { fg = "#181818" }
end

return M
