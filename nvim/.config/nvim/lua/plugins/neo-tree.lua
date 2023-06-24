return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = { "Neotree" },
  keys = {
    {
      "<leader>k",
      "<cmd>Neotree toggle<cr>",
    },
    -- {
    --   "-",
    --   "<cmd>Neotree reveal<cr>",
    -- },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.g.neo_tree_remove_legacy_commands = true

    require("neo-tree").setup({
      enable_diagnostics = false,
      popup_border_style = "rounded",
      window = {
        width = 33,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            "Session.vim",
          },
        },
        window = {
          mappings = {
            ["!"] = "run_external_command",
            ["."] = "run_command",
            ["<s-down>"] = "next_git_modified",
            ["<s-up>"] = "prev_git_modified",
            ["C"] = "copy",
            ["c"] = "close_node",
            ["h"] = "fold_left",
            ["l"] = "fold_right",
            ["Ñ"] = "fuzzy_finder",
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

    -- local hi = require("config.highlights").hi
    -- local c = require("config.highlights").colors
    --
    -- hi.NeoTreeEndOfBuffer = { fg = c.black }
    -- hi.NeoTreeStatusLine = { fg = c.black }
    -- hi.NeoTreeStatusLineNC = {}
    -- hi.NeoTreeWinSeparator = { fg = c.black }
  end,
}
