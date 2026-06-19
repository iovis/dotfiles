return {
  "stevearc/oil.nvim",
  -- enabled = false,
  -- dev = true,
  version = "*",
  lazy = false,
  cmd = { "Oil" },
  keys = {
    { ",", "<cmd>Oil --float<cr>" },
    { "-", "<cmd>Oil<cr>" },
    { "_", "<cmd>Oil .<cr>" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local oil = require("oil")
    local actions = require("oil.actions")
    local u = require("config.utils")

    local show_details = false
    u.ex.abbrev("o", "Oil")

    local permission_hlgroups = {
      ["-"] = "NonText",
      ["r"] = "DiagnosticSignWarn",
      ["w"] = "DiagnosticSignError",
      ["x"] = "DiagnosticSignOk",
    }

    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      lsp_file_methods = { autosave_changes = true },
      columns = { { "icon", add_padding = false } },
      float = {
        max_height = 0.5,
        max_width = 0.5,
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
      use_default_keymaps = false,
      keymaps = {
        -- Defaults
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        [","] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gx"] = "actions.open_external",
        ["gh"] = "actions.toggle_hidden",
        ["gs"] = {
          nowait = true,
          "actions.change_sort",
        },
        -- Custom
        q = { "actions.close", opts = { exit_if_last_buf = true } },
        gt = "actions.toggle_trash",
        ["<m-p>"] = "actions.preview",
        ["<m-j>"] = "actions.preview_scroll_down",
        ["<m-k>"] = "actions.preview_scroll_up",
        ["<bs>"] = "actions.refresh",
        ["<leader>y"] = "actions.copy_to_system_clipboard",
        ["<leader>p"] = "actions.paste_from_system_clipboard",
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
          desc = "Open the entry in new tab",
          callback = function()
            if vim.w.is_oil_win then
              actions.select.callback({ tab = true })
            else
              vim.cmd.tabnew()
            end
          end,
        },
        ["yod"] = {
          desc = "Toggle file detail view",
          mode = "n",
          callback = function()
            show_details = not show_details

            if show_details then
              oil.set_columns({
                {
                  "permissions",
                  highlight = function(permission_str)
                    local hls = {}
                    for i = 1, #permission_str do
                      local char = permission_str:sub(i, i)
                      table.insert(hls, { permission_hlgroups[char], i - 1, i })
                    end
                    return hls
                  end,
                },
                { "size", highlight = "Special" },
                { "mtime", highlight = "Number" },
                { "icon", add_padding = false },
              })
            else
              oil.set_columns({ "icon", add_padding = false })
            end
          end,
        },
        ["'"] = {
          "actions.open_cmdline",
          desc = "Open the command line with the current item as an argument",
          nowait = true,
          opts = {
            shorten_path = true,
            -- modify = ":h",
          },
        },
      },
    })
  end,
}
