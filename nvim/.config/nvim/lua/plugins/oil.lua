return {
  "stevearc/oil.nvim",
  -- enabled = false,
  -- dev = true,
  lazy = false,
  cmd = { "Oil" },
  keys = {
    { "-", "<cmd>Oil --float<cr>" },
    { "_", "<cmd>Oil<cr>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local oil = require("oil")
    local actions = require("oil.actions")
    local u = require("config.utils")

    local show_details = false
    u.alias_command("Oil")

    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      float = {
        max_height = 20,
        max_width = 75,
      },
      use_default_keymaps = false,
      keymaps = {
        -- Defaults
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        -- Custom
        q = "actions.close",
        gt = "actions.toggle_trash",
        ["<m-p>"] = "actions.preview",
        ["<m-j>"] = "actions.preview_scroll_down",
        ["<m-k>"] = "actions.preview_scroll_up",
        ["<bs>"] = "actions.refresh",
        ["<leader>v"] = {
          desc = "Open the entry in a vertical split",
          callback = function()
            if vim.w.is_oil_win then
              actions.select.callback({ vertical = true })
            else
              vim.cmd.wincmd("v")
            end
          end,
        },
        ["<leader>h"] = {
          desc = "Open the entry in a horizontal split",
          callback = function()
            if vim.w.is_oil_win then
              actions.select.callback({ horizontal = true })
            else
              vim.cmd.wincmd("s")
            end
          end,
        },
        ["<leader>t"] = {
          "actions.select",
          opts = { tab = true },
          desc = "Open the entry in new tab",
        },
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            show_details = not show_details

            if show_details then
              oil.set_columns({ "permissions", "size", "mtime", "icon" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
        [","] = {
          "actions.open_cmdline",
          desc = "Open the command line with the current item as an argument",
          opts = {
            shorten_path = true,
            -- modify = ":h",
          },
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
