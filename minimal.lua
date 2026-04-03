-- Keymap
vim.g.mapleader = vim.keycode("<space>")

vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", ",", "<cmd>Ex<cr>")
vim.keymap.set("n", "<bs>", "<c-^>")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "<leader>0", "<c-w>=")
vim.keymap.set("n", "<leader>;", "<cmd>noh<cr><cmd>echon<cr>")
vim.keymap.set("n", "<leader>=", "<c-w>=")
vim.keymap.set("n", "<leader>H", "<c-w>H")
vim.keymap.set("n", "<leader>J", "<c-w>J")
vim.keymap.set("n", "<leader>K", "<c-w>K")
vim.keymap.set("n", "<leader>L", "<c-w>L")
vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader>c", "<c-w>c")
vim.keymap.set("n", "<leader>e", ":e!<space>")
vim.keymap.set("n", "<leader>h", "<c-w>s")
vim.keymap.set("n", "<leader>k", "<cmd>20Lex<cr>")
vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>w", "<cmd>w! ++p<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>")
vim.keymap.set("n", "<m-,>", "<cmd>tabmove -1<cr>")
vim.keymap.set("n", "<m-.>", "<cmd>tabmove +1<cr>")
vim.keymap.set("n", "<m-h>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<m-j>", "<cmd>m+<cr>==")
vim.keymap.set("n", "<m-k>", "<cmd>m-2<cr>==")
vim.keymap.set("n", "<m-l>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<s-tab>", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<tab>", "<cmd>bp|bd #<cr>")
vim.keymap.set("n", "J", "m`J``")
vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "gcu", "gcgc")
vim.keymap.set("n", "yoi", "<cmd>set list!<cr>")
vim.keymap.set("n", "yow", "<cmd>set wrap!<cr>")
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", "<m-j>", ":m'>+<cr>`<my`>mzgv=gv`yo`z", { silent = true })
vim.keymap.set("x", "<m-k>", ":m'<-2<cr>`>my`<mzgv=gv`yo`z", { silent = true })
vim.keymap.set("x", ">", ">gv")
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "o", "x" }, "ao", "aW")
vim.keymap.set({ "o", "x" }, "io", "iW")

-- Options
vim.g.netrw_banner = 0

vim.o.background = "dark"
vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy"
vim.o.cursorline = true
vim.opt.diffopt = {
	"internal",
	"filler",
	"closeoff",
	"indent-heuristic",
	"inline:char",
	"linematch:200",
	"context:12",
	"algorithm:histogram",
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
vim.o.list = false
vim.o.laststatus = 3
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
vim.o.winborder = "rounded"
vim.o.wrap = false

-- Highlights
vim.api.nvim_set_hl(0, "Normal", { bg = nil })
vim.api.nvim_set_hl(0, "StatusLine", { link = "LineNr" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "LineNr" })
vim.api.nvim_set_hl(0, "WinSeparator", { link = "LineNr" })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("my.highlight_yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ timeout = 75 })
	end,
})

-- -- Treesitter
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("my.treesitter_start", { clear = true }),
-- 	callback = function()
-- 		pcall(vim.treesitter.start)
-- 	end,
-- })
--
-- -- LSP
-- vim.env.PATH = vim.env.HOME .. "/.local/share/nvim/mason/bin" .. ":" .. vim.env.PATH
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("my.lsp", {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
-- 		if client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--
-- 			vim.keymap.set("i", "<c-b>", function()
-- 				vim.lsp.completion.get()
-- 			end, { buffer = args.buf })
-- 		end
--
-- 		if
-- 				not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting")
-- 		then
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
-- 				buffer = args.buf,
-- 				callback = function()
-- 					vim.lsp.buf.format({
-- 						bufnr = args.buf,
-- 						id = client.id,
-- 						timeout_ms = 1000,
-- 					})
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })
--
-- vim.lsp.enable({
-- 	"gopls",
-- 	"lua_ls",
-- 	"ts_ls",
-- })
--
-- vim.lsp.config("lua_ls", {
-- 	cmd = { "lua-language-server" },
-- 	filetypes = { "lua" },
-- 	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", ".git" },
-- })
--
-- vim.lsp.config("gopls", {
-- 	cmd = { "gopls" },
-- 	filetypes = { "go", "gomod", "gowork", "gotmpl" },
-- 	root_markers = { "go.work", "go.mod", ".git" },
-- })
