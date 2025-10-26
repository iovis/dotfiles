return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      beacon = {
        enable = false,
      },
      definition = {
        width = 0.8,
        height = 0.6,
        keys = {
          edit = "M",
          vsplit = "<leader>v",
          split = "<leader>h",
          tabe = "<leader>t",
          quit = "q",
        },
      },
      diagnostic = {
        keys = {
          exec_action = "<cr>",
        },
      },
      finder = {
        -- TODO: Implementation seems broken?
        keys = {
          toggle_or_open = "<cr>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
      },
      outline = {
        keys = {
          toggle_or_jump = "<cr>",
        },
      },
      rename = {
        auto_save = true,
        keys = {
          quit = "<esc>",
        },
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = " ",
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        lines = { "└", "├", "│", "─", "┌" },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local bufnr = event.buf

        if not client then
          return
        end

        ---- definition
        vim.keymap.set("i", "<c-h>", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufnr })
        vim.keymap.set("n", "gd", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufnr })
        vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", { buffer = bufnr })

        vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufnr })
        vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>", { buffer = bufnr })

        ---- actions
        vim.keymap.set("i", "<m-j>", "<cmd>Lspsaga code_action<cr>", { buffer = bufnr })
        vim.keymap.set({ "n", "x" }, "<leader>la", "<cmd>Lspsaga code_action<cr>", { buffer = bufnr })
        vim.keymap.set({ "n", "x" }, "<leader>lr", "<cmd>Lspsaga rename<cr>", { buffer = bufnr })

        ---- diagnostics
        vim.keymap.set("n", "<m-d>", "<cmd>Lspsaga show_line_diagnostics<cr>", { buffer = bufnr })
        vim.keymap.set("n", "<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { buffer = bufnr })
        vim.keymap.set("n", "<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>", { buffer = bufnr })

        ---- outline
        vim.keymap.set("n", "<leader>lm", "<cmd>Lspsaga outline<cr>", { buffer = bufnr })
      end,
    })
  end,
}
