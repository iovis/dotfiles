---- muxi
if vim.fn.expand("%"):match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buffer = true })
---- Cargo (crates.nvim)
elseif vim.fn.expand("%"):match("Cargo.toml") then
  local crates = require("crates")
  local opts = { buffer = true }

  crates.show()

  -- TODO:
  --  - This PR may introduce an `on_attach` hook: https://github.com/Saecki/crates.nvim/pull/65

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
  -- vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
  vim.keymap.set("n", "<leader>cr", crates.open_repository, opts)
  vim.keymap.set("n", "<leader>co", crates.open_documentation, opts)
  vim.keymap.set("n", "<leader>cc", crates.open_crates_io, opts)
end
