return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = { "Neotree" },
  keys = {
    {
      "<leader>k",
      "<cmd>Neotree toggle<cr>",
    },
    {
      "<leader>-",
      "<cmd>Neotree reveal<cr>",
    },
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
        use_libuv_file_watcher = true,
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
            ["-"] = "close_node",
            ["h"] = "fold_left",
            ["l"] = "fold_right",

            ["g?"] = "show_help",
            ["?"] = "",

            ["g."] = "toggle_hidden",
            H = "",

            S = "",
            ["<leader>h"] = "open_split",

            s = "",
            ["<leader>v"] = "open_vsplit",

            t = "",
            ["<leader>t"] = "open_tabnew",
          },
        },
        commands = {
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
            local parent_id = node:get_parent_id()

            require("neo-tree.ui.renderer").focus_node(state, parent_id)

            local parent = state.tree:get_node(parent_id)
            if parent.type == "directory" and parent:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, parent)
            end
          end,

          fold_right = function(state)
            local node = state.tree:get_node()
            if node.type ~= "directory" then
              return
            end

            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            end

            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end,
        },
      },
    })
  end,
}
