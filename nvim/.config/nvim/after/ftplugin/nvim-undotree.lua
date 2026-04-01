-- HACK: prevent auto-folding
-- See: $VIMRUNTIME/pack/dist/opt/nvim.undotree/lua/undotree.lua:241
vim.wo.foldmethod = "indent"

local opts = { buf = 0, nowait = true }
vim.keymap.set("n", "q", "<cmd>close<cr>", opts)
vim.keymap.set("n", "<cr>", "<cmd>close<cr>", opts)
