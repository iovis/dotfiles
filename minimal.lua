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

vim.o.autocomplete = true
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
vim.o.expandtab = true
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
vim.opt.listchars:append({
  tab = ">-",
  trail = "·",
  nbsp = "+",
  eol = " ",
  leadmultispace = "│·",
  space = "·",
})
vim.o.number = true
vim.o.pumborder = "rounded"
vim.o.pumheight = 10
vim.o.pummaxwidth = 40
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

local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [sev.ERROR] = "",
      [sev.HINT] = "",
      [sev.INFO] = "",
      [sev.WARN] = "",
    },
  },
})

-- Highlights
vim.api.nvim_set_hl(0, "Normal", { bg = nil })
vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "PmenuSel", { link = "CursorLine" })
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

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("my.treesitter_start", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.lsp.enable({
  "lua_ls",
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", ".git" },
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },

})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local bufnr = event.buf

    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
      vim.keymap.set("i", "<c-b>", vim.lsp.completion.get, { buf = bufnr })
    end

    vim.keymap.set("n", "<leader>lR", ":lsp restart<cr>")

    vim.keymap.set("n", "t", vim.lsp.buf.definition, { buf = bufnr, desc = "vim.lsp.buf.definition" })
    vim.keymap.set("n", "<leader>lx", vim.lsp.codelens.run, { buf = bufnr, desc = "vim.lsp.codelens.run" })
    vim.keymap.set("n", "gd", vim.lsp.buf.hover, { buf = bufnr, desc = "vim.lsp.buf.hover" })
    vim.keymap.set("n", "T", vim.lsp.buf.references, { buf = bufnr, desc = "vim.lsp.buf.references" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buf = bufnr, desc = "vim.lsp.buf.type_definition" })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buf = bufnr, desc = "vim.lsp.buf.code_action" })
    vim.keymap.set({ "n", "x" }, "<leader>lr", vim.lsp.buf.rename, { buf = bufnr, desc = "vim.lsp.buf.rename" })
    vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, {
      desc = "vim.lsp.buf.document_symbol",
      buf = bufnr,
    })
    vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, {
      desc = "vim.lsp.buf.workspace_symbol",
      buf = bufnr,
    })
    vim.keymap.set("n", "<left>", function()
      vim.diagnostic.jump({
        count = -1,
        float = true,
      })
    end, { buf = bufnr, desc = "vim.diagnostic.jump prev" })

    vim.keymap.set("n", "<right>", function()
      vim.diagnostic.jump({
        count = 1,
        float = true,
      })
    end, { buf = bufnr, desc = "vim.diagnostic.jump next" })

    if client:supports_method("textDocument/inlayHint") then
      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        vim.notify("Inlay hints: " .. tostring(vim.lsp.inlay_hint.is_enabled()), vim.log.levels.WARN)
      end

      vim.keymap.set("n", "<leader>lk", toggle_inlay_hints, {
        desc = "toggle vim.lsp.inlay_hint",
        buf = bufnr,
      })
    end

    local function toggle_codelens()
      vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
      vim.notify("LSP Codelens: " .. tostring(vim.lsp.codelens.is_enabled()), vim.log.levels.WARN)
    end

    vim.keymap.set("n", "<leader>lc", toggle_codelens, {
      desc = "toggle vim.lsp.codelens",
      buf = bufnr,
    })

    vim.keymap.set("n", "<leader>fo", ":LspFormat<cr>", { buf = bufnr })
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        id = client.id,
        timeout_ms = 1000,
      })
    end, {})

    -- if
    --    not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting")
    -- then
    --  vim.api.nvim_create_autocmd("BufWritePre", {
    --    group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
    --    buffer = bufnr,
    --    callback = function()
    --      vim.lsp.buf.format({
    --        bufnr = bufnr,
    --        id = client.id,
    --        timeout_ms = 1000,
    --      })
    --    end,
    --  })
    -- end
  end
})
