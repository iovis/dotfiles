return {
  "stevearc/oil.nvim",
  -- enabled = false,
  lazy = false,
  cmd = { "Oil" },
  keys = {
    { "-", "<cmd>Oil<cr>" }, -- --float
    { "_", "<cmd>Oil .<cr>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local oil = require("oil")
    local show_details = false

    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      float = {
        max_height = 20,
        max_width = 75,
      },
      keymaps = {
        P = "actions.preview",
        gt = "actions.toggle_trash",
        q = "actions.close",
        -- ["<leader>v"] = "actions.select_vsplit",
        -- ["<leader>h"] = "actions.select_split",
        -- ["<leader>t"] = "actions.select_tab",
        ["<C-s>"] = false,
        ["<C-p>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-l>"] = false,
        ["`"] = false,
        ["~"] = false,
        ["g\\"] = false,
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            show_details = not show_details

            if show_details then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return vim.tbl_contains({
            "..",
            ".git",
          }, name)
        end,
      },
      win_options = {
        number = true,
        relativenumber = true,
        signcolumn = "yes",
      },
    })
  end,
}
