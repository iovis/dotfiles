---- muxi
if vim.fn.expand("%"):match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buffer = true })
elseif vim.fn.expand("%"):match("Cargo.toml") then
  ---- Cargo
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check Cargo dependencies",
    group = vim.api.nvim_create_augroup("cargo_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      require("config.hooks.dependencies").run("cargo")
    end,
  })
end
