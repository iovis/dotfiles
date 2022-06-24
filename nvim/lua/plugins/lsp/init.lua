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
require("nvim-lsp-installer").setup({})

local servers = {
  "angularls",
  "bashls",
  "dockerls",
  "emmet_ls",
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

for _, server in ipairs(servers) do
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
  server = opts,
})
