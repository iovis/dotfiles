---- Global Variables
vim.g.autoformat = true
vim.g.autotest = nil
vim.g.debug = false
vim.g.foldcolumn = false
-- vim.g.health = { style = "float" }
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.messages_persistent = false
vim.g.scrolloff = 4
vim.g.winbar_full_path = false
vim.g.zig_fmt_autosave = 0

---- Nvim Options
vim.o.autowriteall = true
vim.o.breakindent = true
-- vim.o.cmdheight = 0
vim.o.completeopt = "menu,menuone,noselect"
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
vim.o.expandtab = true
vim.o.exrc = true
vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
}
vim.o.foldcolumn = "0"
vim.o.foldenable = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldtext = "v:lua.require'config.utils'.ui.foldtext()"
vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.jumpoptions = "stack,view"
vim.o.laststatus = 3
vim.opt.listchars:append({
  tab = ">-",
  trail = "·",
  nbsp = "+",
  eol = " ",
  leadmultispace = "│·",
  space = "·",
})
vim.o.messagesopt = "wait:500,history:2000"
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrollback = 100000
vim.o.scrolloff = vim.g.scrolloff
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.showbreak = "└ "
vim.o.showmode = false
vim.o.sidescrolloff = 4
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smoothscroll = true
vim.o.softtabstop = 2
vim.o.spelllang = "en_us"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statuscolumn = require("config.statuscol").statuscolumn()
vim.o.swapfile = false
vim.o.tabclose = "uselast"
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 200
vim.o.virtualedit = "block"
vim.o.wildignore = "*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn"
vim.o.wildignorecase = true
vim.o.winborder = "rounded"
vim.o.wrap = false

---- Session Options
vim.opt.sessionoptions:remove("folds")
-- vim.opt.sessionoptions:remove("blank")
-- vim.opt.sessionoptions:append("localoptions")

---- Disable legacy providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
