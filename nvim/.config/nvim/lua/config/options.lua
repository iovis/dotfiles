---- Set Space as the leader key
vim.g.mapleader = " "

---- Global Variables
vim.g.autoformat = true
vim.g.autotest = nil
vim.g.zig_fmt_autosave = 0

---- Nvim Options
vim.o.autowriteall = true
vim.o.breakindent = true
-- vim.o.cmdheight = 2
vim.o.completeopt = "menu,menuone,noselect"
vim.o.cursorline = true
vim.opt.diffopt:append("hiddenoff,vertical")
vim.o.expandtab = true
vim.o.fillchars = [[diff:╱,eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
-- vim.o.lazyredraw = true
vim.opt.listchars:append({
  lead = "·",
  -- tab = ">-",
  tab = "│ ",
  trail = "-",
  nbsp = "+",
  eol = " ",
  leadmultispace = "│   ",
  multispace = "│   ",
})
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.showbreak = "└ "
vim.o.showmode = false
vim.o.sidescrolloff = 4
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.spelllang = "en_us"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 200
vim.o.virtualedit = "block"
vim.o.wildignore = "*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn"
vim.o.wildignorecase = true
vim.o.wrap = false

---- Session Options
-- vim.opt.sessionoptions:remove("blank")
-- vim.opt.sessionoptions:remove("folds")
-- vim.opt.sessionoptions:append("localoptions")

---- Disable legacy providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
