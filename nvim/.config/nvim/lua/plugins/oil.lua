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

    oil.setup({
      default_file_explorer = true,
      lsp_rename_autosave = true,
      skip_confirm_for_simple_edits = true,
      float = {
        max_height = 20,
        max_width = 75,
        win_options = {
          winblend = 0,
        },
      },
      keymaps = {
        q = "actions.close",
        gt = "actions.toggle_trash",
        ["<leader>p"] = "actions.preview",
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
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        number = true,
        relativenumber = true,
        signcolumn = "yes",
      },
    })

    local oil_augroup = vim.api.nvim_create_augroup("oil_augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Accept changes with <CR>",
      group = oil_augroup,
      pattern = "oil_preview",
      callback = function(params)
        vim.keymap.set("n", "<cr>", "o", {
          buffer = params.buf,
          remap = true,
          nowait = true,
        })
      end,
    })

    -- Fugitive expects netrw to exist, otherwise to define your own `:Browse`
    vim.api.nvim_create_user_command("Browse", function(opts)
      -- bowser's castle
      vim.cmd.Browser(vim.fn.escape(opts.args, "%#!"))
    end, { nargs = 1 })
  end,
}
