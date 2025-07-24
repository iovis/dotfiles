-- Keymap
vim.g.mapleader = vim.keycode("<space>")

vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", ",", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>;", "<cmd>noh<cr><cmd>echon<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>e", ":e!<space>")
vim.keymap.set("n", "<leader>h", "<c-w>s")
vim.keymap.set("n", "<leader>k", "<cmd>Lex<cr>")
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "<bs>", "<c-^>")
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

-- Options
vim.g.netrw_banner = 0

vim.o.background = "dark"
vim.o.completeopt = "menu,menuone,popup,fuzzy"
vim.o.cursorline = true
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
  "hiddenoff",
  "vertical",
}
vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
	stl = "─",
	stlnc = "─",
}
vim.o.foldenable = true
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.ignorecase = true
vim.o.list = true
vim.opt.listchars = {
  tab = "▏ ",
  trail = "·",
  extends = "»",
  precedes = "«",
}
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.shiftwidth = 0
vim.o.showmode = false
vim.o.sidescrolloff = 4
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabclose = "uselast"
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200
vim.o.virtualedit = "block"
vim.o.wrap = false

vim.api.nvim_set_hl(0, "Normal", { bg = nil })
vim.api.nvim_set_hl(0, "StatusLine", { link = "LineNr" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "LineNr" })
vim.api.nvim_set_hl(0, "WinSeparator", { link = "LineNr" })

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- LSP
vim.env.PATH = vim.env.HOME .. "/.local/share/nvim/mason/bin" .. ":" .. vim.env.PATH
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
  end,
})

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ts_ls",
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", ".git" },
})
