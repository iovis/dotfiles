-- HACK: prevent auto-folding
-- See: $VIMRUNTIME/pack/dist/opt/nvim.undotree/lua/undotree.lua:241
vim.wo.foldmethod = "indent"
