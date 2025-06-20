return {
  "folke/snacks.nvim",
  version = "*",
  priority = 1000,
  config = function()
    -- TODO:
    -- - gitblame -> blame.nvim
    local snacks = require("snacks")
    local grep_exclude = {
      ".git/",
      ".gitattributes",
      ".venv/",
      "node_modules/",
    }

    snacks.setup({
      dim = {
        scope = {
          min_size = 3,
          -- max_size = 20,
          siblings = false,
        },
        animate = { enabled = false },
      },
      explorer = {},
      input = { enabled = true },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            win = {
              list = {
                keys = {
                  [","] = "explorer_up",
                  ["."] = "explorer_focus",
                  ["<s-down>"] = "explorer_git_next",
                  ["<s-up>"] = "explorer_git_prev",
                  ["<m-j>"] = "preview_scroll_down",
                  ["<m-k>"] = "preview_scroll_up",
                  ["<leader>h"] = "edit_split",
                  ["<leader>t"] = "tab",
                  ["<leader>v"] = "edit_vsplit",
                },
              },
            },
          },
          files = { hidden = true },
          filetypes = {
            name = "filetypes",
            format = "text",
            preview = "none",
            layout = { preset = "vscode" },
            confirm = function(picker, item)
              picker:close()

              if item then
                vim.schedule(function()
                  vim.cmd("setfiletype " .. item.text)
                end)
              end
            end,
            finder = function()
              local items = {}
              local filetypes = vim.fn.getcompletion("", "filetype")
              for _, type in ipairs(filetypes) do
                items[#items + 1] = {
                  text = type,
                }
              end
              return items
            end,
          },
          grep = {
            exclude = grep_exclude,
          },
        },
        win = {
          input = {
            keys = {
              ["<F2>"] = { "toggle_maximize", mode = { "n", "i" } },
              ["<c-a>"] = "",
              ["<c-u>"] = "list_scroll_up",
              ["<esc>"] = { "close", mode = { "n", "i" } },
              ["<m-a>"] = { "select_all", mode = { "n", "i" } },
              ["<m-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["<m-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
              ["<m-q>"] = { "qflist", mode = { "n", "i" } },
              ---@diagnostic disable-next-line: assign-type-mismatch
              ["<m-cr>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            },
          },
        },
      },
      zen = {
        on_open = function(_win)
          -- clear messages on open
          vim.cmd.nohlsearch()
          vim.cmd.echon()
        end,
        toggles = { dim = false },
        win = {
          height = 0.9,
          wo = {
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            list = false,
            number = false,
            relativenumber = false,
            signcolumn = "no",
            winbar = "",
          },
        },
      },
      styles = {
        input = {
          keys = {
            i_esc = { "<esc>", { "cancel" }, mode = "i", expr = true },
          },
        },
      },
    })

    ----Gitbrowse
    vim.keymap.set({ "n", "x" }, "<leader>gG", snacks.gitbrowse.open, { desc = "snacks.gitbrowse.open" })

    ----Explorer
    vim.keymap.set("n", "<leader>k", function()
      snacks.explorer()
    end, { desc = "snacks.explorer" })

    ----Picker
    vim.keymap.set("n", "s<space>", function()
      snacks.picker()
    end, { desc = "snacks.picker" })

    vim.keymap.set("n", "<leader>R", snacks.picker.registers, { desc = "snacks.picker.registers" })
    vim.keymap.set("n", "<leader>f/", snacks.picker.lines, { desc = "snacks.picker.lines" })
    vim.keymap.set("n", "<leader>fh", snacks.picker.help, { desc = "snacks.picker.help" })
    vim.keymap.set("n", "<leader>fm", snacks.picker.man, { desc = "snacks.picker.man" })
    vim.keymap.set("n", "<leader>fq", snacks.picker.qflist, { desc = "snacks.picker.qflist" })
    vim.keymap.set("n", "<leader>o", snacks.picker.files, { desc = "snacks.picker.files" })
    vim.keymap.set("n", "<leader>r", snacks.picker.resume, { desc = "snacks.picker.resume" })
    vim.keymap.set("n", "gm", snacks.picker.buffers, { desc = "snacks.picker.buffers" })

    vim.keymap.set("n", "<leader>j", function()
      snacks.picker.git_status({ focus = "list" })
    end, { desc = "snacks.picker.git_status" })

    vim.keymap.set("n", "U", function()
      snacks.picker.undo({
        focus = "list",
        layout = { preset = "bottom" },
      })
    end, { desc = "snacks.picker.undo" })

    ---@diagnostic disable-next-line: undefined-field
    vim.keymap.set("n", "<leader>F", snacks.picker.filetypes, { desc = "snacks.picker.filetypes" })

    -- Files
    vim.keymap.set("n", "<leader>ud", function()
      snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Open Neovim config" })

    -- Grep
    vim.keymap.set({ "n", "x" }, "<leader>fi", function()
      snacks.picker.grep_word({
        exclude = grep_exclude,
        focus = "list",
        hidden = true,
      })
    end, { desc = "snacks.picker.grep_word" })

    vim.keymap.set("n", "<leader>fk", function()
      snacks.picker.grep({
        search = "\\w",
        live = false,
        hidden = true,
        exclude = grep_exclude,
      })
    end, { desc = "snacks.picker.grep" })

    vim.keymap.set("n", "<leader>fl", function()
      snacks.picker.grep({ hidden = true, exclude = grep_exclude })
    end, { desc = "snacks.picker.grep" })

    -- LSP
    vim.keymap.set("n", "<leader>ls", snacks.picker.lsp_symbols, { desc = "snacks.picker.lsp_symbols" })
    vim.keymap.set("n", "<leader>lw", snacks.picker.lsp_workspace_symbols, {
      desc = "snacks.picker.lsp_workspace_symbols",
    })

    vim.keymap.set("n", "<leader>ld", function()
      snacks.picker.diagnostics({ focus = "list" })
    end, { desc = "snacks.picker.diagnostics" })

    ----Zen
    vim.keymap.set("n", "<leader>z", snacks.zen.zen, { desc = "snacks.zen.zen" })
    vim.api.nvim_create_user_command("ZenMode", function()
      snacks.zen.zen()
    end, {})

    ----Dim
    vim.keymap.set("n", "yoT", "<cmd>Dim<cr>")
    vim.api.nvim_create_user_command("Dim", function()
      -- Doesn't support toggling yet
      if snacks.dim.enabled then
        snacks.dim.disable()
      else
        snacks.dim.enable()
      end
    end, {})
  end,
}
