local kulala = require("kulala")

vim.keymap.set("n", "<leader>si", kulala.run, { buffer = true })
vim.keymap.set("n", "<leader>so", kulala.run_all, { buffer = true })
vim.keymap.set("n", "s<cr>", kulala.run, { buffer = true })
vim.keymap.set("n", "<cr>", kulala.run, { buffer = true })

vim.keymap.set("n", "gd", kulala.inspect, { buffer = true })
vim.keymap.set("n", "<left>", kulala.jump_prev, { buffer = true })
vim.keymap.set("n", "<right>", kulala.jump_next, { buffer = true })

vim.keymap.set("n", "<leader>gql", kulala.download_graphql_schema, { buffer = true })

vim.keymap.set("n", "<leader>yc", kulala.copy, {
  buffer = true,
  desc = "Copy the current request as a curl command",
})

vim.keymap.set("n", "<leader>P", kulala.from_curl, {
  buffer = true,
  desc = "Paste curl from clipboard as http request",
})
