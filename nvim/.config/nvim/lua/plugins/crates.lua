return {
  "saecki/crates.nvim",
  -- tag = "v0.3.0",
  ft = { "rust", "toml" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jose-elias-alvarez/null-ls.nvim", -- code actions
  },
  config = function()
    local crates = require("crates")

    crates.setup({
      highlight = {
        version = "Comment",
      },
      null_ls = {
        enabled = true,
      },
      popup = {
        autofocus = true,
        border = "rounded",
      },
      text = {
        version = "    %s", -- Extra space to make room for lspsaga's lightbulb
      },
      on_attach = function(bufnr)
        crates.show()

        local opts = { buffer = bufnr }

        -- UI
        vim.keymap.set("n", "<leader>cR", crates.reload, opts)
        vim.keymap.set("n", "<leader>ct", crates.toggle, opts)

        -- Popup
        vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
        vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
        vim.keymap.set("n", "<leader>cs", crates.show_crate_popup, opts)
        vim.keymap.set("n", "<leader>cl", crates.show_popup, opts)
        vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)

        -- Updates
        vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
        vim.keymap.set("x", "<leader>cu", crates.update_crates, opts)
        vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
        vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
        vim.keymap.set("x", "<leader>cU", crates.upgrade_crates, opts)
        vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

        -- Links
        vim.keymap.set("n", "<leader>ch", crates.open_homepage, opts)
        vim.keymap.set("n", "<leader>cr", crates.open_repository, opts)
        vim.keymap.set("n", "<leader>co", crates.open_documentation, opts)
        vim.keymap.set("n", "<leader>cc", crates.open_crates_io, opts)
      end,
    })
  end,
}
