local kulala = require("kulala")

vim.lsp.enable("kulala_ls")

vim.keymap.set("n", "<leader>si", kulala.run, { buf = 0 })
vim.keymap.set("n", "<leader>so", kulala.run_all, { buf = 0 })
vim.keymap.set("n", "s<cr>", kulala.run, { buf = 0 })
vim.keymap.set("n", "<cr>", kulala.run, { buf = 0 })

vim.keymap.set("n", "gd", kulala.inspect, { buf = 0 })
vim.keymap.set("n", "<left>", kulala.jump_prev, { buf = 0 })
vim.keymap.set("n", "<right>", kulala.jump_next, { buf = 0 })

vim.keymap.set("n", "<leader>gql", kulala.download_graphql_schema, { buf = 0 })

vim.keymap.set("n", "<leader>yc", kulala.copy, {
  buf = 0,
  desc = "Copy the current request as a curl command",
})

vim.keymap.set("n", "<leader>P", kulala.from_curl, {
  buf = 0,
  desc = "Paste curl from clipboard as http request",
})
