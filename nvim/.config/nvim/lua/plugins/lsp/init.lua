---- LSP Setting files
local config = require("plugins.lsp.config")
local scan = require("plenary.scandir")

local lsp_settings_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/settings"
local lsp_settings_files = scan.scan_dir(lsp_settings_path, { depth = 0 })

local lsp_settings = {}

for _, file in ipairs(lsp_settings_files) do
  local language = file:match("([^/]+).lua$")

  lsp_settings[language] = require("plugins.lsp.settings." .. language)
end

---- Initialize servers
local lsp_servers = {
  "angularls",
  "bashls",
  "dockerls",
  "emmet_ls",
  "gopls",
  "html",
  "jsonls",
  "pyright",
  -- "sorbet",
  "solargraph",
  "sqls",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "vimls",
}

require("neodev").setup({})

require("mason").setup({
  ui = {
    keymaps = {
      apply_language_filter = "Ñ",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
})

for _, server in ipairs(lsp_servers) do
  local opts = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }

  -- Autoloading of plugins.lsp.settings.*
  if lsp_settings[server] then
    opts = vim.tbl_deep_extend("force", lsp_settings[server], opts)
  end

  require("lspconfig")[server].setup(opts)
end

---- Rust
-- rust-tools likes to be special
local opts = {
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  standalone = false,
}

opts = vim.tbl_deep_extend("force", lsp_settings["rust_analyzer"], opts)

require("rust-tools").setup({
  -- tools = {
  --   on_initialized = function()
  --     vim.lsp.codelens.refresh()
  --   end,
  -- },
  server = opts,
})
