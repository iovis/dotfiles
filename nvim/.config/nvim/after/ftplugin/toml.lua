local u = require("config.utils")

---- muxi
if u.current_file():match("muxi/") then
  vim.keymap.set("n", "m<cr>", ":silent !muxi init<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !muxi init<cr>", { buffer = true })
elseif u.current_file() == "Cargo.toml" then
  ---- Cargo
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
    desc = "Check Cargo dependencies",
    group = vim.api.nvim_create_augroup("cargo_dependencies", { clear = true }),
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      require("config.hooks.dependencies").run("cargo")
    end,
  })
elseif u.current_file() == "aerospace.toml" then
  vim.keymap.set("n", "s<cr>", ":silent !aerospace reload-config<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>so", ":silent !aerospace reload-config<cr>", { buffer = true })
end
