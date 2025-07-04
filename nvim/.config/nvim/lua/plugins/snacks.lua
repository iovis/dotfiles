return {
  "folke/snacks.nvim",
  version = "*",
  priority = 1000,
  config = function()
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
                  ["<c-j>"] = false,
                  ["<c-k>"] = false,
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
                items[#items + 1] = { text = type }
              end

              return items
            end,
          },
          grep = { exclude = grep_exclude },
          registers = {
            actions = {
              delete = function(picker)
                local items = picker:selected({ fallback = true })

                for _, item in ipairs(items) do
                  vim.fn.setreg(item.reg, "")
                end

                -- refresh list
                picker.list:set_selected()
                picker.list:set_target()
                picker:find()
              end,
              edit = function(picker)
                local item = picker:selected({ fallback = true })[1]

                if item.data:match("\n") then
                  Snacks.win({
                    width = 0.6,
                    height = 0.6,
                    border = "rounded",
                    title = ("  [%s] register  "):format(item.reg),
                    fixbuf = true,
                    text = vim.split(item.data, "\n"),
                    keys = { q = "close" },
                    zindex = 1000,
                    on_close = function(_win)
                      local new_value = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
                      vim.fn.setreg(item.reg, new_value or "")

                      -- refresh list
                      picker.list:set_selected()
                      picker.list:set_target()
                      picker:find()
                    end,
                  })
                else
                  vim.ui.input({ prompt = item.reg, default = item.data }, function(input)
                    vim.fn.setreg(item.reg, input or "")

                    -- refresh list
                    picker.list:set_selected()
                    picker.list:set_target()
                    picker:find()
                  end)
                end
              end,
              execute_macro = function(picker)
                local item = picker:selected({ fallback = true })[1]

                if #item.data > 0 then
                  picker:close()
                  vim.cmd.normal("@" .. item.reg)
                end
              end,
            },
            win = {
              input = {
                keys = {
                  ["<c-x>"] = { "delete", mode = { "n", "i" } },
                  ["<m-cr>"] = { "execute_macro", mode = { "n", "i" } },
                  d = "delete",
                  e = "edit",
                },
              },
              list = {
                keys = {
                  ["<c-x>"] = "delete",
                  ["<m-cr>"] = "execute_macro",
                  d = "delete",
                  e = "edit",
                },
              },
            },
          },
        },
        win = {
          input = {
            keys = {
              ["<F2>"] = { "toggle_maximize", mode = { "n", "i" } },
              ["<c-a>"] = "",
              ["<c-u>"] = "list_scroll_up",
              ["<esc>"] = { "close", mode = { "n", "i" } },
              ["<leader>H"] = "layout_left",
              ["<leader>J"] = "layout_bottom",
              ["<leader>K"] = "layout_top",
              ["<leader>L"] = "layout_right",
              ["<m-.>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<m-a>"] = { "select_all", mode = { "n", "i" } },
              ["<m-h>"] = "",
              ["<m-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["<m-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
              ["<m-q>"] = { "qflist", mode = { "n", "i" } },
              ---@diagnostic disable-next-line: assign-type-mismatch
              ["<m-cr>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<leader>H"] = "layout_left",
              ["<leader>J"] = "layout_bottom",
              ["<leader>K"] = "layout_top",
              ["<leader>L"] = "layout_right",
              ["<m-.>"] = "toggle_hidden",
              ["<m-a>"] = "select_all",
              ["<m-cr>"] = { "pick_win", "jump" },
              ["<m-j>"] = "preview_scroll_down",
              ["<m-k>"] = "preview_scroll_up",
              ["<m-q>"] = "qflist",
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

    ----Explorer
    vim.keymap.set("n", "<leader>k", function()
      snacks.explorer()
    end, { desc = "snacks.explorer" })

    ----Gitbrowse
    vim.keymap.set({ "n", "x" }, "<leader>gG", snacks.gitbrowse.open, { desc = "snacks.gitbrowse.open" })

    ----Picker
    ---@diagnostic disable-next-line: undefined-field
    vim.keymap.set("n", "<leader>F", snacks.picker.filetypes, { desc = "snacks.picker.filetypes" })
    vim.keymap.set("n", "<leader>/", snacks.picker.lines, { desc = "snacks.picker.lines" })
    vim.keymap.set("n", "<leader>fh", snacks.picker.help, { desc = "snacks.picker.help" })
    vim.keymap.set("n", "<leader>fm", snacks.picker.man, { desc = "snacks.picker.man" })
    vim.keymap.set("n", "<leader>fq", snacks.picker.qflist, { desc = "snacks.picker.qflist" })
    vim.keymap.set("n", "<leader>o", snacks.picker.files, { desc = "snacks.picker.files" })
    vim.keymap.set("n", "<leader>r", snacks.picker.resume, { desc = "snacks.picker.resume" })
    vim.keymap.set("n", "gm", snacks.picker.buffers, { desc = "snacks.picker.buffers" })
    vim.keymap.set("n", "s<space>", snacks.picker.pick, { desc = "snacks.picker.pick" })

    vim.keymap.set("n", "<leader>j", function()
      snacks.picker.git_status({ focus = "list" })
    end, { desc = "snacks.picker.git_status" })

    vim.keymap.set("n", "<leader>R", function()
      snacks.picker.registers({ pattern = "label:" })
    end, { desc = "snacks.picker.registers" })

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

    ----Rename
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })

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
